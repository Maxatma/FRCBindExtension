//
//  ViewController.swift
//  RKTests
//
//  Created by Alexander Zaporozhchenko on 7/1/16.
//  Copyright © 2016 Alexander Zaporozhchenko. All rights reserved.
//

import UIKit
import ReactiveUIKit
import ReactiveKit
import TTRangeSlider
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var secondColor : Property<UIColor>!
    var secondString : String!
    
    var managedObjectContext: NSManagedObjectContext!
    var datasource : CollectionProperty <NSFetchedResultsController>?
    
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest             = NSFetchRequest(entityName: "Person")
        let sortDescriptor           = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath:"name", cacheName: nil)
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate           = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        datasource                = CollectionProperty(fetchedResultsController)
        
        
        let array = ["test", "value", "third", "total", "5th"]
        for value in array {
            let person  = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext:managedObjectContext) as! Person
            person.name = value
        }
        
        add()
        
        do {
            try datasource?.value.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        
        datasource!.bindTo(tableView) { indexPath, datasource, tableView in
            
            let cell             = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
            let person : Person  = datasource[indexPath.row] as! Person
            cell.textLabel?.text = person.name
            return cell
        }
        
        //        let addOperation : Operation = Operation<Void,NSError>{ observer in
        //            self.add()
        //            observer.next()
        //            observer.completed()
        //            return NotDisposable
        //        }
        
        addBarButton.rTap.observeNext {
            self.add()
            }.disposeIn(rBag)
    }
    
    func add() {
        let person        = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext:managedObjectContext) as! Person
        let date : NSDate = NSDate()
        person.name       = "name : \(date)"

    }
    
}

