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
    func tableViewCell(_ tableView: UITableView, indexPath: IndexPath, cellData:NSManagedObject?) -> UITableViewCell;
}

open class BaseTableViewFRCDataManager: BaseTVCFetchRequestDataManger {
    
    // MARK: FetchResultsController
    
    open var _fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    open var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
        assert(_fetchedResultsController == nil , "This variable should be override in sub calss")
        return NSFetchedResultsController()
    }
    
    /**
     Use this method in ordert to get the section title
     - parameter section: The section index
     */
    open func headerName(_ section:Int) -> String? {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.name
    }
}


// MARK: - UITableViewDataSource

extension BaseTableViewFRCDataManager: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.fetchedResultsController.object(at: indexPath) as? NSManagedObject
        return self.tableViewCell(tableView, indexPath: indexPath, cellData: cellData)
    }
}

// MARK: - SelectItemDataSourceDelegate

extension BaseTableViewFRCDataManager: SelectItemDataManagerDelegate {
    
    public func tableViewCell(_ tableView: UITableView, indexPath: IndexPath, cellData: NSManagedObject?) -> UITableViewCell {
        assert(true, "Oevrride this method in your subclass")
        return UITableViewCell()
    }
}
