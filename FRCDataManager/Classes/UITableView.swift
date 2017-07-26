//
//  UITableView.swift
//  Kinderpedia
//
//  Created by Mandea Daniel on 23/09/15.
//  Copyright © 2015 Mandea Daniel. All rights reserved.
//

import Foundation
import CoreData

public extension UITableView {
  
  /**
   * Use this method in order to scroll to some indexpath with delay
   * :param   delay       The dealy of action perform
   * :param   indexPath   The index path that should scroll to
   * :param   scrollPosition The position of scrolling
   * :param   animated Used to define if the action should be animated
   */
  public func scrollToIndexPathWithDelay(_ delay:Double, indexPath: IndexPath, scrollPosition: UITableViewScrollPosition, animated: Bool) {
    let delay = delay * Double(NSEC_PER_SEC)
    let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time, execute: {
      self.scrollToIndexPath(indexPath, scrollPosition: scrollPosition, animated: animated)
    })
  }
  
  /**
   * Use this method in order to scroll to some indexpath
   * :param   indexPath   The index path that should scroll to
   * :param   scrollPosition The position of scrolling
   * :param   animated Used to define if the action should be animated
   */
  public func scrollToIndexPath(_ indexPath: IndexPath, scrollPosition: UITableViewScrollPosition, animated: Bool) {
    self.scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    self.reloadRows(at: [indexPath], with: .automatic)
  }
  
  /**
   Use this method in order to check if some indexPath is valid
   - parameter indexPath: The indexpath that needs to be checked
   */
  public func indexPathIsValid(_ indexPath: IndexPath) -> Bool {
    let section = (indexPath as NSIndexPath).section
    let row = (indexPath as NSIndexPath).row
    
    let lastSectionIndex = self.numberOfSections - 1
    
    //Make sure the specified section exists
    if section > lastSectionIndex {
      return false
    }
    let rowCount = self.numberOfRows(inSection: (indexPath as NSIndexPath).section) - 1
    return row <= rowCount
  }
  
}

// MARK: - NSFetchedResultsControllerDelegate

extension UITableView: NSFetchedResultsControllerDelegate {
  
  open func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    self.beginUpdates()
  }
  
  open func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    switch type {
    case .insert:
      self.insertSections(IndexSet(integer: Int(sectionIndex)), with: .automatic)
      break
    case .delete:
      self.deleteSections(IndexSet(integer: Int(sectionIndex)), with: .automatic)
      break
    case .update:
      self.reloadSections(IndexSet(integer: Int(sectionIndex)), with: .automatic)
      break
    default:
      break
    }
  }
  
  open func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case NSFetchedResultsChangeType(rawValue: 0)!:
      // iOS 8 bug - Do nothing if we get an invalid change type.
      break;
    case .insert:
      if let indexPath = newIndexPath {
        self.insertRows(at: [indexPath], with: .automatic)
      }
      break
    case .delete:
      if let indexPath = indexPath {
        self.deleteRows(at: [indexPath], with: .automatic)
      }
      
      break
    case .move:
      if let indexPath = indexPath {
        self.deleteRows(at: [indexPath], with: .automatic)
      }
      
      if let newIndexPath = newIndexPath {
        self.insertRows(at: [newIndexPath], with: .automatic)
      }
      
      break
      
    case .update:
      if let indexPath = indexPath {
        self.reloadRows(at: [indexPath], with: .automatic)
      }
      
      break
    }
  }
  
  open func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    self.endUpdates()
  }
}

// MARK: - FetchRequestDelegate

extension UITableView: FetchRequestDelegate {
  
  public func shouldReload() {
    self.reloadData()
  }
 
  public func scroll(at indexPath: IndexPath){
    self.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
  }
}
