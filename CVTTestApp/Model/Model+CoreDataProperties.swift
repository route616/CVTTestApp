//
//  Student+CoreDataProperties.swift
//  CVTTestApp
//
//  Created by Игорь on 05.05.2021.
//
//

import Foundation
import CoreData


extension Student {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var averageScore: Int16
}

extension Student : Identifiable {

}
