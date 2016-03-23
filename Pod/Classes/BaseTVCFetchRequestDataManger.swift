//
//  BaseTVCFetchRequestDataManger.swift
//  Kinderpedia
//
//  Created by Mandea Daniel on 01/10/15.
//  Copyright © 2015 Mandea Daniel. All rights reserved.
//

import UIKit
import CoreData
import UIKit

class BaseTVCFetchRequestDataManger: NSObject {
    
    // MARK: - Public Setters 
    
    var delegate: BaseTVCFetchRequestDelegate?
    var positionDelegate: UpdateListPositionDelegate?
    var errorDelegate: NSErrorDelegate?
    var controllerDelegate: UIViewControllerDelegate?
    
    // MARK: - Public Setters
    
    var searchText:String? {
        didSet {
            // Override in your class
        }
    }
    
    var predicate:NSPredicate? {
        get {
            // Override in your class
            return nil
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension BaseTVCFetchRequestDataManger: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.delegate?.controllerWillChangeContent()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
            self.delegate?.sectionChanged(sectionIndex, forChangeType: type)
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        self.delegate?.itemChanged(indexPath, forChangeType: type, newIndexPath: newIndexPath)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.delegate?.controllerDidChangeContent()
    }
}

// MARK: - Protocol: BaseTVCFetchRequestDelegate

/**
This protocol is used to notify a list view that should upate the cells and sections 
*/
@objc protocol BaseTVCFetchRequestDelegate {
    
    func itemChanged(indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?)
    
    func sectionChanged(sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType)
    
    func controllerWillChangeContent()
    
    func controllerDidChangeContent()
    
    func controllerShouldReloadData()
}

/**
 This protocol is used in order to notify the receiver that should change position
 */
@objc protocol UpdateListPositionDelegate: BaseTVCFetchRequestDelegate {
   
    func shouldScrollToRowAtIndexPath(indexPath: NSIndexPath)
}
