//
//  Favorito+CoreDataProperties.swift
//  
//
//  Created by Paula Matsumoto on 17/11/21.
//
//

import Foundation
import CoreData


extension Favorito {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorito> {
        return NSFetchRequest<Favorito>(entityName: "Favorito")
    }
    
    @NSManaged public var imagem: String?
    @NSManaged public var nome: String?
}
