//
//  DetailPresenter.swift
//  CVTTestApp
//
//  Created by Игорь on 06.05.2021.
//

final class DetailPresenter {
    private var student: Student?
    private weak var view: DetailViewProtocol?

    init() {}

    init(with student: Student) {
        self.student = student
    }

    func setView(view: DetailViewProtocol) {
        self.view = view
    }

    func loadStudent() {
        view?.firstName = student?.firstName
        view?.lastName = student?.lastName
        if let averageScore = student?.averageScore {
            view?.averageScore = Double(averageScore)
        }
    }

    func save() {
        guard let firstName = view?.firstName, firstName.isValid() else {
            view?.showInvalidNameAlert()
            return
        }

        guard let lastName = view?.lastName, lastName.isValid() else {
            view?.showInvalidNameAlert()
            return
        }

        guard let averageScore = view?.averageScore, averageScore.isValid() else {
            view?.showInvalidScoreAlert()
            return
        }

        DatabaseService.shared.appendStudent(
            firstName: firstName, lastName: lastName, averageScore: Int16(Int(averageScore))
        )

        view?.backToList()
    }

    func cancel() {
        view?.backToList()
    }
}
