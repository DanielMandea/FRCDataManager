//
//  FRCSetupGateway.swift
//  FRCDataManager
//
//  Created by DanielMandea on 3/31/18.
//

import Foundation

public protocol FRCSetupGateway {
  
  weak var delegate: FetchRequestDelegate? {get set}
  var sortDescriptors: Array<NSSortDescriptor>! {get set}
  var fetchSize: Int! {get set}
  var predicate: NSPredicate? {get set}
  func reset()
}
