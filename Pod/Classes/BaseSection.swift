//
//  BaseSection.swift
//  News
//
//  Created by Mandea Daniel on 2/27/16.
//  Copyright © 2016 Mandea Daniel. All rights reserved.
//

import UIKit

open class BaseSection: NSObject {
    
    // MARK: - Public Variables
    
    /// retains all the cells
   open var cells:Array<BaseCell>
    /// Retains headaer data
   open var headerData: AnyObject?
    /// Retains footer data
   open var footerData: AnyObject?
    
    // MARK: - Initialize 
    
    public init(cells:Array<BaseCell>, headerData:AnyObject?, footerData:AnyObject?) {
        self.cells = cells
        self.headerData = headerData
        self.footerData = footerData
        super.init()
    }
    
    public convenience init(cells: Array<BaseCell>, footerData:AnyObject?) {
        self.init(cells:cells, headerData: nil, footerData: footerData)
    }
    
    public convenience init(cells: Array<BaseCell>, headerData:AnyObject?) {
        self.init(cells:cells, headerData: headerData, footerData: nil)
    }
    
    public convenience override init() {
        self.init(cells:[], headerData: nil, footerData: nil)
    }
    
    public convenience init(headerData: AnyObject?) {
        self.init(cells:[], headerData: headerData, footerData: nil)
    }
    
    public convenience init(footerData: AnyObject?) {
        self.init(cells:[], headerData: nil, footerData: footerData)
    }
}
