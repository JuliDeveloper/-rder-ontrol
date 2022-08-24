//
//  Order.swift
//  ОrderСontrol
//
//  Created by Julia Romanenko on 24.08.2022.
//

import Foundation
import CoreData

class Order: NSManagedObject {
    convenience init() {
        // Создание нового объекта
        self.init(entity: StorageManager.shared.entityForName(entityName: "Oredr"), insertInto: StorageManager.shared.context)
    }
}
