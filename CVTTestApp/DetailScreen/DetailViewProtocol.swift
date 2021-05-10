//
//  DetailViewProtocol.swift
//  CVTTestApp
//
//  Created by Игорь on 10.05.2021.
//

protocol DetailViewProtocol: AnyObject {
    var firstName: String? { get set }
    var lastName: String? { get set }
    var averageScore: Double? { get set }

    func showInvalidNameAlert()
    func showInvalidScoreAlert()

    func backToList()
}
