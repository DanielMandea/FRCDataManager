//
//  NSError.swift
//  Kinderpedia
//
//  Created by Mandea Daniel on 01/10/15.
//  Copyright © 2015 Mandea Daniel. All rights reserved.
//

import Foundation

// Use this protocol in oreder to get notifed when an error occured
public protocol ErrorDelegate: class {
  /**
   Register as delegate for this method in order be notified if some error was encountered by the data manager
   - parameter error: The error that was encountered
   */
  func react(for error: Error)
}
