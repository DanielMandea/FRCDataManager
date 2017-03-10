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
   func tableView(_ tableView: UITableView, cellForIndexPath indexPath: IndexPath, cellData:BaseCell) -> UITableViewCell;
}

public protocol DataSourceDelegate {
    /// This method get's called if the data source was updated
    func dataSourceUpdated()
}

open class BaseDataSource: NSObject {
    
    /// Retains the sections in Data Source
    open var sections:Array<BaseSection>
    open var delegate: DataSourceDelegate?
    
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
    open func cellDataForIndexPath(_ indexPath:IndexPath) -> BaseCell {
        let section = self.sections[(indexPath as NSIndexPath).section]
        return section.cells[(indexPath as NSIndexPath).row]
    }
    
    /***
     This method should be called in order to configure table view cell with related data
     - parameter cell:      The table view that will dequeue the cell
     - parameter indexPath: The indexPath of the cell that should be configured
     */
    open func configure(cell: UITableViewCell, for indexPath: IndexPath) {
        assert(true, "Please override this method into your sublcass in order to configure your cell")
    }
}

// MARK: - DataSourceDelegate

extension BaseDataSource: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].cells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.cellDataForIndexPath(indexPath)
        return self.tableView(tableView, cellForIndexPath: indexPath, cellData: cellData)
    }
    
    open func tableView(_ tableView: UITableView, cellForIndexPath indexPath: IndexPath, cellData:BaseCell) -> UITableViewCell {
        assert(true, "Please override this method into your sublcass")
        return UITableViewCell()
    }
}

// MARK: - UICollectionViewDataSource

extension BaseDataSource: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[section].cells.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = self.cellDataForIndexPath(indexPath)
        return self.collectionView(collectionView, cellForIndexPath: indexPath, cellData: cellData)
    }

    open func collectionView(_ collectionView: UICollectionView, cellForIndexPath indexPath: IndexPath, cellData:BaseCell) -> UICollectionViewCell {
        assert(true, "Please override this method into your sublcass")
        return UICollectionViewCell()
    }
}
