//
//  BaseCell.swift
//  News
//
//  Created by Mandea Daniel on 2/27/16.
//  Copyright © 2016 Mandea Daniel. All rights reserved.
//

import UIKit

public class BaseCell: NSObject {
    
    // MARK: - Public variables
    
    /// Cell indentifier
    public var identifier:String
    /// The data that will populate the cell
    public var data: AnyObject?
    
    // MARK: - Initialize 
    
    /// Use this designated initialiser if both identifer and data are needed
    public init(identifier:String, data: AnyObject?) {
        self.identifier = identifier
        self.data = data
        super.init()
    }
    
    /// Use this convenience initializer if only identifier is needed
    public convenience init(identifier:String) {
        self.init(identifier: identifier, data: nil)
    }
}
