//
//  BaseTableViewFRCDataManager.swift
//  CashControl
//
//  Created by Mandea Daniel on 1/28/16.
//  Copyright © 2016 MindMagnet. All rights reserved.
//

import UIKit
import CoreData

// MARK: - FetchResultsController

/**
 This is the right way to fetch data from fetch results controller
 
 -> nr of sections
 self.fetchedResultsController.sections?.count ?? 0
 
 -> nr of cells
 guard let sections =  self.fetchedResultsController.sections,
 sections.indices.contains(section) else {
 return 0
 
 -> Managed Object
 self.fetchedResultsController.object(at: indexPath)
 
 */

/**
 Use this protocol in order to create a fetch results controller
 */
public protocol FetchResultsController: class {
    
    associatedtype ManagedObject: NSFetchRequestResult
    associatedtype CellType: Any
    
    var _fetchedResultsController: NSFetchedResultsController<ManagedObject>? { get set }
    var fetchedResultsController: NSFetchedResultsController<ManagedObject> { get }
    
    /***
     This method should be called in order to configure table view cell with related data
     - parameter cell:      The table view that will dequeue the cell
     - parameter indexPath: The indexPath of the cell that should be configured
     */
    func configure(cell: CellType, for indexPath: IndexPath)
}
