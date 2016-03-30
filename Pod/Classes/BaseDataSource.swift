//
//  BaseDataSource.swift
//  News
//
//  Created by Mandea Daniel on 2/27/16.
//  Copyright © 2016 Mandea Daniel. All rights reserved.
//

import UIKit

public protocol DataSource: UITableViewDataSource {
    
    /// This is a method that should be override in your sublcas if you use TV
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, cellData:BaseCell) -> UITableViewCell;
}

public protocol DataSourceDelegate {
    /// This method get's called if the data source was updated
    func dataSourceUpdated()
}

public class BaseDataSource: NSObject {
    
    /// Retains the sections in Data Source
    public var sections:Array<BaseSection>
    public var delegate: DataSourceDelegate?
    
    // MARK: - Initialize
    
    /// Designated initializer
    public init(sections: Array<BaseSection>) {
        self.sections = sections
        super.init()
    }
    
    /// Convenience initializer
    public convenience override init() {
        self.init(sections:[])
    }
    
    // MARK: - Public Methods 
    
    /// Returns CellData for some IndexPath
    public func cellDataForIndexPath(indexPath:NSIndexPath) -> BaseCell {
        let section = self.sections[indexPath.section]
        return section.cells[indexPath.row]
    }
    
}

// MARK: - DataSourceDelegate

extension BaseDataSource: UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].cells.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellData = self.cellDataForIndexPath(indexPath)
        return self.tableView(tableView, cellForRowAtIndexPath: indexPath, cellData: cellData)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, cellData:BaseCell) -> UITableViewCell {
        assert(true, "Please override this method into your sublcass")
        return UITableViewCell()
    }
}
