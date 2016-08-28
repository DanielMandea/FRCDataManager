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
    public func scrollToIndexPathWithDelay(_ delay:Double, indexPath: IndexPath, scrollPosition: UITableViewScrollPosition, animated: Bool) {
        let delay = delay * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time, execute: {
            self.scrollToIndexPath(indexPath, scrollPosition: scrollPosition, animated: animated)
        })
    }
    
    /**
    * Use this method in order to scroll to some indexpath
    * :param   indexPath   The index path that should scroll to
    * :param   scrollPosition The position of scrolling
    * :param   animated Used to define if the action should be animated
    */
    public func scrollToIndexPath(_ indexPath: IndexPath, scrollPosition: UITableViewScrollPosition, animated: Bool) {
        self.scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
        self.reloadRows(at: [indexPath], with: .automatic)
    }
    
    /**
     Use this method in order to check if some indexPath is valid 
     - parameter indexPath: The indexpath that needs to be checked
     */
    public func indexPathIsValid(_ indexPath: IndexPath) -> Bool {
        let section = (indexPath as NSIndexPath).section
        let row = (indexPath as NSIndexPath).row
        
        let lastSectionIndex = self.numberOfSections - 1
        
        //Make sure the specified section exists
        if section > lastSectionIndex {
            return false
        }
        let rowCount = self.numberOfRows(inSection: (indexPath as NSIndexPath).section) - 1
        return row <= rowCount
    }
    
}

// MARK: - BaseTVCFetchRequestDelegate

extension UITableView: BaseTVCFetchRequestDelegate {
    
    public func controllerWillChangeContent() {
        self.beginUpdates()
    }
    
    public func sectionChanged(_ sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    public func itemChanged(_ indexPath: IndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            self.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            // Move sections only if needed else reload them
            if let _indexPath = indexPath,
                let _newIndexPath = newIndexPath {
                    if self.indexPathIsValid(_indexPath) {
                        if (_indexPath as NSIndexPath).section != (_newIndexPath as NSIndexPath).section && (_newIndexPath as NSIndexPath).row !=  (_newIndexPath as NSIndexPath).row {
                            self.deleteRows(at: [indexPath!], with: .fade)
                            self.insertRows(at: [newIndexPath!], with: .fade)
                        } else  {
                            self.reloadRows(at: [indexPath!], with: .fade)
                        }
                    }
            }
        }
    }
    
    public func controllerDidChangeContent() {
        self.endUpdates()
    }
    
    public func controllerShouldReloadData() {
        self.reloadData()
    }
}
