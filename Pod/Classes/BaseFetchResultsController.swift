//
//  BaseTableViewFRCDataManager.swift
//  CashControl
//
//  Created by Mandea Daniel on 1/28/16.
//  Copyright © 2016 MindMagnet. All rights reserved.
//

import UIKit
import CoreData

// MARK: - BaseFetchResultsController

public protocol BaseFetchResultsController: class {
    
    associatedtype ManagedObject:NSFetchRequestResult

    var _fetchedResultsController: NSFetchedResultsController<ManagedObject>? { get set }
    var fetchedResultsController: NSFetchedResultsController<ManagedObject> { get }
    
    /***
     This method should be called in order to configure table view cell with related data 
     - parameter cell:      The table view that will dequeue the cell
     - parameter indexPath: The indexPath of the cell that should be configured 
     */
    func configure(cell: UITableViewCell, for indexPath: IndexPath)
}

// MARK: - TableViewDataSource

public protocol TableViewDataSource: class {
    
    associatedtype ManagedObject: NSManagedObject
    
    /**
     Use this method in order to get the number of sections available
     return:  The number of sections available 
     */
    func sections() -> Int // Default is 1 if not implemented
    
    /**
     Use this method in order to get the number of rows in some section
     - parameter section: The section that should return the number of rows
     return:  The number of cells in some sections
     */
    func cells(in section: Int) -> Int
    
    /**
     Use this method in order get an managed object for index path
     - parameter indexPath: The indexPath of the cell that will be dequeued
     return:  The data that will be used in order to update dequeued cell
     */
    func data(for indexPath: IndexPath) -> ManagedObject?
}

// MARK: - TableViewDataSource where Self: BaseFetchResultsController

public extension TableViewDataSource where Self: BaseFetchResultsController {
    
    public func sections() -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    public func cells(in section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    public func data(for indexPath: IndexPath) -> ManagedObject {
        return self.fetchedResultsController.object(at: indexPath)
    }
}
