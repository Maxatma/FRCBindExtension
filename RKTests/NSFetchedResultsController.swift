//
//  NSFetchedResultController.swift
//  RKTests
//
//  Created by Alexander Zaporozhchenko on 7/4/16.
//  Copyright © 2016 Alexander Zaporozhchenko. All rights reserved.
//

import Foundation
import CoreData
import ReactiveKit

enum NSFetchedResultsControllerError: ErrorType {
    case OutOfBounds
    case NoElements
}

extension NSFetchedResultsController : CollectionType {
    public typealias Index   = Int
    public typealias Element = NSManagedObject
    public typealias Error   = ErrorType
    
    #if swift(>=3.0)
    public typealias Iterator = AnyIterator<Element>
    #else
    public typealias Generator = AnyGenerator<Element>
    public typealias Iterator  = Generator
    #endif
    
    #if swift(>=3.0)
    #else
    public func generate() -> Generator {
        return makeIterator()
    }
    #endif
    
    
    public var startIndex: Int {
        return 0
    }
    
    public var endIndex: Int {
        return fetchedObjects?.count ?? 0
    }
    
    public var count: Int {
        return fetchedObjects?.count ?? 0
    }

    public func makeIterator() -> Iterator {
        let index = startIndex
        
        return Iterator {
            if self.endIndex > index {
                return self[index]
            } else {
                return nil
            }
        }
    }
    
    public subscript (position: Index) -> Element {
        guard position <= count else {
              fatalError("Index out of range")
        }
        
        return (fetchedObjects?[position] ?? nil)! as! Element
    }
    
}