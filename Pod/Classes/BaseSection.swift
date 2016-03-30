//
//  BaseSection.swift
//  News
//
//  Created by Mandea Daniel on 2/27/16.
//  Copyright © 2016 Mandea Daniel. All rights reserved.
//

import UIKit

class BaseSection: NSObject {
    
    // MARK: - Public Variables
    
    /// retains all the cells
    var cells:Array<BaseCell>
    /// Retains headaer data
    var headerData: AnyObject?
    /// Retains footer data
    var footerData: AnyObject?
    
    // MARK: - Initialize 
    
    init(cells:Array<BaseCell>, headerData:AnyObject?, footerData:AnyObject?) {
        self.cells = cells
        self.headerData = headerData
        self.footerData = footerData
        super.init()
    }
    
    convenience init(cells: Array<BaseCell>, footerData:AnyObject?) {
        self.init(cells:cells, headerData: nil, footerData: footerData)
    }
    
    convenience init(cells: Array<BaseCell>, headerData:AnyObject?) {
        self.init(cells:cells, headerData: headerData, footerData: nil)
    }
    
    convenience override init() {
        self.init(cells:[], headerData: nil, footerData: nil)
    }
    
    convenience init(headerData: AnyObject?) {
        self.init(cells:[], headerData: headerData, footerData: nil)
    }
    
    convenience init(footerData: AnyObject?) {
        self.init(cells:[], headerData: nil, footerData: footerData)
    }
}
