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

class FRCollectionView: UICollectionView, CollectionViewProcessUpdates {
    
    // MARK: - Init
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        updateOperations = [BlockOperation]()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateOperations = [BlockOperation]()
    }
    
    // MARK: - CollectionViewProcessUpdates
    
    var updateOperations: Array<BlockOperation>?
    
    func addUpdateOperation(block:@escaping (Void)->Void) {
        updateOperations?.append(BlockOperation(block: block))
    }
    
    func clearUpdateStack() {
        updateOperations?.removeAll()
    }
    
    // MARK: - deinit
    
    deinit {
        // Cancel all block operations when VC deallocates
        if let operations = updateOperations {
            for operation in operations {
                operation.cancel()
            }
            clearUpdateStack()
        }
    }
}

// MARK: - CollectionViewProcessUpdates

protocol CollectionViewProcessUpdates {
    
    var updateOperations: Array<BlockOperation>? {get set}
    
    func addUpdateOperation(block:@escaping (Void)->Void)
    
    func clearUpdateStack()
}

// MARK: - NSFetchedResultsControllerDelegate

extension NSFetchedResultsControllerDelegate where Self: CollectionViewProcessUpdates, Self: UICollectionView {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            addUpdateOperation {self.insertItems(at: [newIndexPath!])}
        case .update:
            addUpdateOperation {self.reloadItems(at: [indexPath!])}
        case .move:
            addUpdateOperation {
                // If installsStandardGestureForInteractiveMovement is on
                // the UICollectionViewController will handle this on its own.
                guard #available(iOS 9.0, *), self.beginInteractiveMovementForItem(at: indexPath!) else {
                    return
                }
                self.moveItem(at: indexPath!, to: newIndexPath!)
            }
        case .delete:
            addUpdateOperation {self.deleteItems(at: [indexPath!])}
        }
        
    }
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            addUpdateOperation { self.insertSections(IndexSet(integer: sectionIndex))}
        case .update:
            addUpdateOperation {self.reloadSections(IndexSet(integer:sectionIndex))}
        case .delete:
            addUpdateOperation {self.deleteSections(IndexSet(integer: sectionIndex))}
        case .move:
            // Not something I'm worrying about right now.
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.performBatchUpdates({ () -> Void in
            // Cancel all block operations when VC deallocates
            guard let operations = self.updateOperations else {
                return
            }
            for operation in operations {
                operation.start()
            }
        }, completion: { (finished) -> Void in
            self.clearUpdateStack()
        })
    }
}

// MARK: - FetchRequestDelegate

extension UICollectionView: FetchRequestDelegate {
    
    public func shouldReload() {
        self.reloadData()
    }
    
    public func scroll(at indexPath: IndexPath){
        self.scrollToItem(at: indexPath, at: .top, animated: true)
    }
}

