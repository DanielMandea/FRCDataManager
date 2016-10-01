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
    
    /**
     Oevrride this method in order to set some cell for some indexPath
     - parameter tableView: The table view that will dequeue the cell
     - parameter indexPath: The indexPath of the cell that will be dequeued
     - parameter cellData:  The data that will be used in order to update dequeued cell
     */
    func tableViewCell(_ tableView: UITableView, indexPath: IndexPath, cellData:ManagedObject?) -> UITableViewCell;
}

// MARK: - TableViewDataSource

public protocol TableViewDataSource {
    
    @available(iOS 2.0, *)
    func _numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    
    @available(iOS 2.0, *)
    func _tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
   
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    @available(iOS 2.0, *)
    func _tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

// MARK: - ExtendedTableViewDataSource

public protocol ExtendedTableViewDataSource: TableViewDataSource {
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    
    
    // Editing
    
    // Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    
    
    // Moving/reordering
    
    // Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    
    
    // Index
    
    @available(iOS 2.0, *)
    func sectionIndexTitles(for tableView: UITableView) -> [String]? // return list of section titles to display in section index view (e.g. "ABCD...Z#")
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int // tell table which section corresponds to section title/index (e.g. "B",1))
    
    
    // Data manipulation - insert and delete support
    
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    
    
    // Data manipulation - reorder / moving support
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}

// MARK: - TableViewDataSource where Self: BaseFetchResultsController

public extension TableViewDataSource where Self: BaseFetchResultsController {
    
    public func _numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }

    public func _tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    public func _tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.fetchedResultsController.object(at: indexPath)
        return self.tableViewCell(tableView, indexPath: indexPath, cellData: cellData)
    }
}


