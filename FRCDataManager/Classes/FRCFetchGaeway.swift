//
//  FRCFetchGaeway.swift
//  FRCDataManager
//
//  Created by DanielMandea on 3/31/18.
//

import Foundation
import CoreData

protocol FRCFetchGateway {
    
    func sections() -> Int
    
    func rows(in section: Int) -> Int
    
    func object(at indexPath: IndexPath) -> NSManagedObject
}
