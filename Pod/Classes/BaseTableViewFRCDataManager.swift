//
//  BaseTableViewFRCDataManager.swift
//  CashControl
//
//  Created by Mandea Daniel on 1/28/16.
//  Copyright © 2016 MindMagnet. All rights reserved.
//

import UIKit
import CoreData

public protocol SelectItemDataManagerDelegate {
    /**
     Oevrride this method in order to set some cell for some indexPath
     - parameter tableView: The table view that will dequeue the cell
     - parameter indexPath: The indexPath of the cell that will be dequeued
     - parameter cellData:  The data that will be used in order to update dequeued cell
     */
    func tableViewCell(tableView: UITableView, indexPath: NSIndexPath, cellData:NSManagedObject?) -> UITableViewCell;
}

public class BaseTableViewFRCDataManager: BaseTVCFetchRequestDataManger {
    
    // MARK: FetchResultsController
    
    public var _fetchedResultsController: NSFetchedResultsController?
    public var fetchedResultsController: NSFetchedResultsController {
        assert(_fetchedResultsController == nil , "This variable should be override in sub calss")
        return NSFetchedResultsController()
    }
    
    /**
     Use this method in ordert to get the section title
     - parameter section: The section index
     */
    public func headerName(section:Int) -> String? {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.name
    }
}


// MARK: - UITableViewDataSource

extension BaseTableViewFRCDataManager: UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellData = self.fetchedResultsController.objectAtIndexPath(indexPath) as? NSManagedObject
        return self.tableViewCell(tableView, indexPath: indexPath, cellData: cellData)
    }
}

// MARK: - SelectItemDataSourceDelegate

extension BaseTableViewFRCDataManager: SelectItemDataManagerDelegate {
    
    public func tableViewCell(tableView: UITableView, indexPath: NSIndexPath, cellData: NSManagedObject?) -> UITableViewCell {
        assert(true, "Oevrride this method in your subclass")
        return UITableViewCell()
    }
}