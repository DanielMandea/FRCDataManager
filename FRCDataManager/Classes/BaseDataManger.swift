//
//  BaseTVCFetchRequestDataManger.swift
//  Kinderpedia
//
//  Created by Mandea Daniel on 01/10/15.
//  Copyright © 2015 Mandea Daniel. All rights reserved.
//

import UIKit
import CoreData

open class BaseDataManger: NSObject {
  
  // MARK: - Delegates
  
  open weak var delegate: FetchRequestDelegate?
  
  // MARK: - Public Setters
  
  open var searchText:String? {
    didSet {
      // Override in your class
    }
  }
  
  open var predicate:NSPredicate? {
    get {
      // Override in your class
      return nil
    }
  }
}

