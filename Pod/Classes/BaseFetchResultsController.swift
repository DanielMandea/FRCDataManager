//
//  BaseTableViewFRCDataManager.swift
//  CashControl
//
//  Created by Mandea Daniel on 1/28/16.
//  Copyright © 2016 MindMagnet. All rights reserved.
//

import UIKit
import CoreData

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

public extension UITableViewDataSource where Self: BaseFetchResultsController {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.fetchedResultsController.object(at: indexPath)
        return self.tableViewCell(tableView, indexPath: indexPath, cellData: cellData)
    }
}
