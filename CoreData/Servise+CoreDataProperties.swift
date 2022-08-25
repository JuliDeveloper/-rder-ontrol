//
//  Servise+CoreDataProperties.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//
//

import Foundation
import CoreData


extension Servise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Servise> {
        return NSFetchRequest<Servise>(entityName: "Servise")
    }

    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var rowsOfOrders: NSSet?

}

// MARK: Generated accessors for rowsOfOrders
extension Servise {

    @objc(addRowsOfOrdersObject:)
    @NSManaged public func addToRowsOfOrders(_ value: RowOfOrder)

    @objc(removeRowsOfOrdersObject:)
    @NSManaged public func removeFromRowsOfOrders(_ value: RowOfOrder)

    @objc(addRowsOfOrders:)
    @NSManaged public func addToRowsOfOrders(_ values: NSSet)

    @objc(removeRowsOfOrders:)
    @NSManaged public func removeFromRowsOfOrders(_ values: NSSet)

}

extension Servise : Identifiable {

}
