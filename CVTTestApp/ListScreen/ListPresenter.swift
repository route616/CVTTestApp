//
//  ListPresenter.swift
//  CVTTestApp
//
//  Created by Игорь on 06.05.2021.
//

import Foundation
import UIKit

final class ListPresenter {
    private var students = [Student]() {
        didSet {
            DispatchQueue.main.async {
                self.view?.update()
            }
        }
    }
    private weak var view: ListViewProtocol?

    var studentCount: Int {
        return students.count
    }

    func setView(view: ListViewProtocol) {
        self.view = view
    }

    func loadStudentList() {
        students = DatabaseService.shared.fetchStudentList()
    }

    func deleteStudent(with index: Int) {
        DatabaseService.shared.delete(student: students[index])
        students = DatabaseService.shared.fetchStudentList()
    }

    func configure(cell: UITableViewCell, row: Int) {
        let student = students[row]
        cell.textLabel?.text = "\(student.firstName) \(student.lastName)"
        cell.detailTextLabel?.text = "\(student.averageScore)"
    }

    func showDetails(row: Int) {
        let nextPresenter = DetailPresenter(with: students[row])
        view?.showDetails(with: nextPresenter)
    }

    func showDetails() {
        let nextPresenter = DetailPresenter()
        view?.showDetails(with: nextPresenter)
    }
}
