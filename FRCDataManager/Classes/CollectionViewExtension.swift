//
//  UICollectionViewExtension.swift
//  FRCDataManager
//
//  Created by Mandea Daniel on 04/03/2019.
//

import Foundation
import CoreData

protocol CollectionViewUpdate { }

// MARK: - NSFetchedResultsControllerDelegate

extension UICollectionView: NSFetchedResultsControllerDelegate  {
    
    open func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            insertSections(IndexSet(integer: Int(sectionIndex)))
            break
        case .delete:
            deleteSections(IndexSet(integer: Int(sectionIndex)))
            break
        case .update:
            reloadSections(IndexSet(integer: Int(sectionIndex)))
            break
        default:
            break
        }
    }
    
    open func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case NSFetchedResultsChangeType(rawValue: 0)!:
            // iOS 8 bug - Do nothing if we get an invalid change type.
            break;
        case .insert:
            if let indexPath = newIndexPath { insertItems(at: [indexPath]) }
            break
        case .delete:
            if let indexPath = indexPath { deleteItems(at: [indexPath]) }
            break
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                moveItem(at: indexPath, to: newIndexPath)
            }
            break

        case .update:
            if let indexPath = indexPath { reloadItems(at: [indexPath]) }
            break
        }
    }
}

// MARK: - FetchRequestDelegate

extension UICollectionView: FetchRequestDelegate {
    
    public func shouldReload() {
        reloadData()
    }
    
    public func scroll(at indexPath: IndexPath){
        scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.top, animated: true)
    }
}
