//
//  DatabaseService.swift
//  CVTTestApp
//
//  Created by Игорь on 07.05.2021.
//

import UIKit

final class DatabaseService {
    static let shared = DatabaseService()
    private init() {}

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchStudentList() -> [Student] {
        var students = [Student]()
        do {
            students = try context.fetch(Student.fetchRequest())
        } catch {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
        return students
    }

    func fetchStudent(with index: Int) -> Student {
        let students = fetchStudentList()
        return students[index]
    }

    func update(
        student: Student, with newFirstName: String, newLastName: String, newAverageScore: Int16
    ) {
        student.firstName = newFirstName
        student.lastName = newLastName
        student.averageScore = newAverageScore
        do {
            try context.save()
        } catch let error {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
    }

    func appendStudent(firstName: String, lastName: String, averageScore: Int16) {
        let student = Student(context: context)
        student.firstName = firstName
        student.lastName = lastName
        student.averageScore = averageScore
        do {
            try context.save()
        } catch {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
    }

    func delete(student: Student) {
        context.delete(student)
        do {
            try context.save()
        } catch {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
    }
}
