# FRCDataManager

Contains multiple helper classes that improves working with NSFetchResultsController. It has full support for UITableView and it's very simple to use. 

ViewController:

```swift
import UIKit
import FRCDataManager
import PullToRefreshSwift

class TopRatedViewController: UIViewController {
    
    // MARK: - Outlets 
    
    @IBOutlet weak var tableView: BaseTableView!
    
    // MARK: - Internal
    
    var dataManager: TopRatedDataManager = {
       return TopRatedDataManager()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup 
        dataManager.queue = ProceduresManager.sharedManager.queue
        dataManager.delegate = tableView
        tableView.dataSource = dataManager
        dataManager.errorDelegate = self
    }
}

```

Data Manager:

```swift
import FRCDataManager
import CoreData

class TopRatedDataManager: BaseTVCFetchRequestDataManger, BaseFetchResultsController, TableViewDataSource {
    
    // MARK: - Init
    
    override init() {
        super.init()
    }
    
    // MARK: - BaseFetchResultsController
    
    typealias ManagedObject=Feed
    
    var _fetchedResultsController: NSFetchedResultsController<ManagedObject>?
    var fetchedResultsController: NSFetchedResultsController<ManagedObject> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        // Setup fetchRequest
        let fetchRequest: NSFetchRequest<Feed> = Feed.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        // Edit the section name key path and cache name if appropriate.
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManger.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Show error
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            self.errorDelegate?.errorEncountered(nserror)
        }
        
        return _fetchedResultsController!
    }
    
    func tableViewCell(_ tableView: UITableView, indexPath: IndexPath, cellData:ManagedObject?) -> UITableViewCell {
        // Setup feed cell
        if let feed = cellData,
            let cell = tableView.dequeueReusableCell(withIdentifier: kFeedTableViewCellReuseIdentifier, for: indexPath) as? FeedTableViewCell {
            cell.feed = feed
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - TopRatedDataManager

extension TopRatedDataManager: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _tableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return _tableView(tableView, cellForRowAt: indexPath)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int  {
        return _numberOfSections(in: tableView)
    }
}

```

Provides support for simple and advances DataSource that helps when a decoupled echosystem is needed.

```swift


```

[![CI Status](http://img.shields.io/travis/Mandea Daniel/FRCDataManager.svg?style=flat)](https://travis-ci.org/Mandea Daniel/FRCDataManager)
[![Version](https://img.shields.io/cocoapods/v/FRCDataManager.svg?style=flat)](http://cocoapods.org/pods/FRCDataManager)
[![License](https://img.shields.io/cocoapods/l/FRCDataManager.svg?style=flat)](http://cocoapods.org/pods/FRCDataManager)
[![Platform](https://img.shields.io/cocoapods/p/FRCDataManager.svg?style=flat)](http://cocoapods.org/pods/FRCDataManager)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

FRCDataManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FRCDataManager"
```

## Author

Mandea Daniel, daniel.mandea@yahoo.com

## License

FRCDataManager is available under the MIT license. See the LICENSE file for more info.
