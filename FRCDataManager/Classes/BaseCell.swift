//
//  BaseCell.swift
//  News
//
//  Created by Mandea Daniel on 2/27/16.
//  Copyright © 2016 Mandea Daniel. All rights reserved.
//

import Foundation

open class BaseCell: NSObject {
  
  // MARK: - Public variables
  
  /// Cell indentifier
  open var identifier:String
  /// The data that will populate the cell
  open var data: Any?
  
  // MARK: - Initialize
  
  /// Use this designated initialiser if both identifer and data are needed
  public init(identifier:String, data: Any?) {
    self.identifier = identifier
    self.data = data
    super.init()
  }
  
  /// Use this convenience initializer if only identifier is needed
  public convenience init(identifier:String) {
    self.init(identifier: identifier, data: nil)
  }
}
