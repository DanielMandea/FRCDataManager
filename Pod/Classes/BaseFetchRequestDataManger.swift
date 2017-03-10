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

open class BaseTVCFetchRequestDataManger: NSObject {
    
    // MARK: - Public Setters 
    
    open weak var delegate: BaseTVCFetchRequestDelegate?
    open weak var positionDelegate: UpdateListPositionDelegate?
    open weak var errorDelegate: NSErrorDelegate?
    open weak var controllerDelegate: UIViewControllerDelegate?
    
    // MARK: - Public Setters
    
    open var searchText:String? {
        didSet {
            // Override in your class
        }
    }
    
    open var predicate:NSPredicate? {
        get {
            // Override in your class
            return nil
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension BaseTVCFetchRequestDataManger: NSFetchedResultsControllerDelegate {
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.delegate?.controllerWillChangeContent()
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
            self.delegate?.sectionChanged(sectionIndex, forChangeType: type)
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.delegate?.itemChanged(indexPath, forChangeType: type, newIndexPath: newIndexPath)
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.delegate?.controllerDidChangeContent()
    }
}

// MARK: - Protocol: BaseTVCFetchRequestDelegate

/**
This protocol is used to notify a list view that should upate the cells and sections 
*/
public protocol BaseTVCFetchRequestDelegate: class {
    
    func itemChanged(_ indexPath: IndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    
    func sectionChanged(_ sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType)
    
    func controllerWillChangeContent()
    
    func controllerDidChangeContent()
    
    func controllerShouldReloadData()
}

/**
 This protocol is used in order to notify the receiver that should change position
 */
public protocol UpdateListPositionDelegate: BaseTVCFetchRequestDelegate {
   
    func shouldScrollToRowAtIndexPath(_ indexPath: IndexPath)
}
