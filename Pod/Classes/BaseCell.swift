//
//  BaseCell.swift
//  News
//
//  Created by Mandea Daniel on 2/27/16.
//  Copyright © 2016 Mandea Daniel. All rights reserved.
//

import UIKit

class BaseCell: NSObject {
    
    // MARK: - Public variables
    
    /// Cell indentifier
    var identifier:String
    /// The data that will populate the cell
    var data: AnyObject?
    
    // MARK: - Initialize 
    
    /// Use this designated initialiser if both identifer and data are needed
    init(identifier:String, data: AnyObject?) {
        self.identifier = identifier
        self.data = data
        super.init()
    }
    
    /// Use this convenience initializer if only identifier is needed
    convenience init(identifier:String) {
        self.init(identifier: identifier, data: nil)
    }
}
