//
//  FRCSetupGateway.swift
//  FRCDataManager
//
//  Created by DanielMandea on 3/31/18.
//

import Foundation

protocol FRCSetupGateway {
    
    var delegate: FetchRequestDelegate? {get set}
    var sortDescriptors: Array<NSSortDescriptor>! {get set}
    var fetchSize: Int! {get set}
    var predicate: NSPredicate? {get set}
    func reset()
}
