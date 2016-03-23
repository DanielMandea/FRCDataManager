//
//  UIViewControllerDelegate.swift
//  CashControl
//
//  Created by Mandea Daniel on 11/24/15.
//  Copyright © 2015 MindMagnet. All rights reserved.
//

import Foundation
/**
 Use this protocol on UIViewController in order to notify the view controller that should perform some action
*/
@objc public protocol UIViewControllerDelegate: NSObjectProtocol {
    /**
     Use this method in order to notify the controller that should dismiss some view controller 
     - parameter viewController: The view controller that will be dismissed
     - parameter flag:           Tells if the operation should be animated 
     - parameter completion:     Called after the operation was completed
     */
    public func shouldDismissViewController(viewController: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    
    /**
     Use this method in order to notify the controller that should present some view controller
     - parameter viewController: The view controller that will be dismissed
     - parameter flag:           Tells if the operation should be animated
     - parameter completion:     Called after the operation was completed
     */
    public func shouldPresentViewController(viewController: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    
    /**
     Use this method in order to notify the controller that should push some view controller
     - parameter viewController: The view controller that will be dismissed
     - parameter flag:           Tells if the operation should be animated
     */
    public func shouldPushViewController(viewController: UIViewController, animated flag: Bool)
}
