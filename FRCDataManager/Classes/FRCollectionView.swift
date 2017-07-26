//
//  UICollectionView.swift
//  Pods
//
//  Created by DanielMandea on 7/25/17.
//
//

import Foundation
import UIKit
import CoreData

class FRCollectionView: UICollectionView {
    
    var fetchedResultsProcessingOperations: [BlockOperation] = []
    
    fileprivate func addFetchedResultsProcessingBlock(processingBlock:@escaping (Void)->Void) {
        fetchedResultsProcessingOperations.append(BlockOperation(block: processingBlock))
    }
    
    
    deinit {
        // Cancel all block operations when VC deallocates
        for operation in fetchedResultsProcessingOperations {
            operation.cancel()
        }
        
        fetchedResultsProcessingOperations.removeAll()
    }
}

extension FRCollectionView: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            addFetchedResultsProcessingBlock {self.insertItems(at: [newIndexPath!])}
        case .update:
            addFetchedResultsProcessingBlock {self.reloadItems(at: [indexPath!])}
        case .move:
            addFetchedResultsProcessingBlock {
                // If installsStandardGestureForInteractiveMovement is on
                // the UICollectionViewController will handle this on its own.
                guard #available(iOS 9.0, *), self.beginInteractiveMovementForItem(at: indexPath!) else {
                    return
                }
                self.moveItem(at: indexPath!, to: newIndexPath!)
            }
        case .delete:
            addFetchedResultsProcessingBlock {self.deleteItems(at: [indexPath!])}
        }
        
    }
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            addFetchedResultsProcessingBlock { self.insertSections(IndexSet(integer: sectionIndex))}
        case .update:
            addFetchedResultsProcessingBlock {self.reloadSections(IndexSet(integer:sectionIndex))}
        case .delete:
            addFetchedResultsProcessingBlock {self.deleteSections(IndexSet(integer: sectionIndex))}
        case .move:
            // Not something I'm worrying about right now.
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.performBatchUpdates({ () -> Void in
            for operation in self.fetchedResultsProcessingOperations {
                operation.start()
            }
        }, completion: { (finished) -> Void in
            self.fetchedResultsProcessingOperations.removeAll(keepingCapacity: false)
        })
    }
}
