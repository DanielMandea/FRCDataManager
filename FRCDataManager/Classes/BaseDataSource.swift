//
//  BaseDataSource.swift
//  News
//
//  Created by Mandea Daniel on 2/27/16.
//  Copyright © 2016 Mandea Daniel. All rights reserved.
//

import Foundation
import UIKit

public protocol DataSourceDelegate: class {
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
  open func configure(tableView cell: UITableViewCell, for indexPath: IndexPath) {
    assert(true, "Please override this method into your sublcass in order to configure your tvc cell")
  }
  
  /***
   This method should be called in order to configure collection view cell with related data
   - parameter cell:      The table view that will dequeue the cell
   - parameter indexPath: The indexPath of the cell that should be configured
   */
  open func configure(collectionView cell: UICollectionViewCell, for indexPath: IndexPath) {
    assert(true, "Please override this method into your sublcass in order to configure your cvc cell")
  }
}

// MARK: - TableViewDataSource where Self: BaseFetchResultsController

public extension TableViewDataSource where Self: BaseDataSource {
  
  public func sections() -> Int {
    return self.sections.count
  }
  
  public func cells(in section: Int) -> Int {
    guard sections.indices.contains(section) else {
      return 0
    }
    return sections[section].cells.count
  }
  
  public func data(for indexPath: IndexPath) -> Any {
    return self.cellDataForIndexPath(indexPath)
  }
}
