//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Evelina on 10.07.2023.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var amount: Int32
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var price: Int32
    @NSManaged public var id: Int64

}
