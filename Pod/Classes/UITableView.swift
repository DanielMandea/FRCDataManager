//
//  UITableView.swift
//  Kinderpedia
//
//  Created by Mandea Daniel on 23/09/15.
//  Copyright © 2015 Mandea Daniel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public extension UITableView {
    
    /**
     * Use this method in order to scroll to some indexpath with delay 
     * :param   delay       The dealy of action perform
     * :param   indexPath   The index path that should scroll to
     * :param   scrollPosition The position of scrolling
     * :param   animated Used to define if the action should be animated
     */
    public func scrollToIndexPathWithDelay(delay:Double, indexPath: NSIndexPath, scrollPosition: UITableViewScrollPosition, animated: Bool) {
        let delay = delay * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.scrollToIndexPath(indexPath, scrollPosition: scrollPosition, animated: animated)
        })
    }
    
    /**
    * Use this method in order to scroll to some indexpath
    * :param   indexPath   The index path that should scroll to
    * :param   scrollPosition The position of scrolling
    * :param   animated Used to define if the action should be animated
    */
    public func scrollToIndexPath(indexPath: NSIndexPath, scrollPosition: UITableViewScrollPosition, animated: Bool) {
        self.scrollToRowAtIndexPath(indexPath, atScrollPosition: scrollPosition, animated: animated)
        self.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    /**
     Use this method in order to check if some indexPath is valid 
     - parameter indexPath: The indexpath that needs to be checked
     */
    public func indexPathIsValid(indexPath: NSIndexPath) -> Bool {
        let section = indexPath.section
        let row = indexPath.row
        
        let lastSectionIndex = self.numberOfSections - 1
        
        //Make sure the specified section exists
        if section > lastSectionIndex {
            return false
        }
        let rowCount = self.numberOfRowsInSection(indexPath.section) - 1
        return row <= rowCount
    }
    
}

// MARK: - BaseTVCFetchRequestDelegate

extension UITableView: BaseTVCFetchRequestDelegate {
    
    public func controllerWillChangeContent() {
        self.beginUpdates()
    }
    
    public func sectionChanged(sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    public func itemChanged(indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case NSFetchedResultsChangeType(rawValue: 0)!:
            // iOS 8 bug - Do nothing if we get an invalid change type.
            break;
        case .Insert:
            if let indexPath = newIndexPath {
                self.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            break
        case .Delete:
            if let indexPath = indexPath {
                self.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            
            break
        case .Move:
            if let indexPath = indexPath {
                self.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            
            if let newIndexPath = newIndexPath {
                self.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
            }
            
            break
            
        case .Update:
            if let indexPath = indexPath {
                self.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            
            break
        }
    }
    
    public func controllerDidChangeContent() {
        self.endUpdates()
    }
    
    public func controllerShouldReloadData() {
        self.reloadData()
    }
}