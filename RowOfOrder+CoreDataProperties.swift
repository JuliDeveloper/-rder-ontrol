//
//  RowOfOrder+CoreDataProperties.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//
//

import Foundation
import CoreData


extension RowOfOrder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RowOfOrder> {
        return NSFetchRequest<RowOfOrder>(entityName: "RowOfOrder")
    }

    @NSManaged public var sum: Float
    @NSManaged public var order: Order?
    @NSManaged public var servise: Servise?

}

extension RowOfOrder : Identifiable {

}
