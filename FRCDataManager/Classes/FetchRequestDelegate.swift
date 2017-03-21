//
//  FetchRequestDelegate.swift
//  Pods
//
//  Created by DanielMandea on 3/21/17.
//
//

import Foundation
import CoreData

// MARK: - Protocol: BaseTVCFetchRequestDelegate

/**
 This protocol is used to notify a list view that should upate the cells and sections
 */
public protocol FetchRequestDelegate: NSFetchedResultsControllerDelegate {
    
    /// This method is called whenever the content should reload
    func shouldReload()
    
    /**
     Called whenever controller should scroll to some index path
     - parameter indexPath: The index controller should scroll to
     */
    func scroll(at indexPath: IndexPath)
}
