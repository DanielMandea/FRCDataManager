//
//  ListDataSource.swift
//  Pods
//
//  Created by DanielMandea on 3/21/17.
//
//

import Foundation

// MARK: - ListDataSource

public protocol ListDataSource: class {
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
  func data(for indexPath: IndexPath) -> Any?
}
