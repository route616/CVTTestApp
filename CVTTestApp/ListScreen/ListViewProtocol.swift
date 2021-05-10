//
//  ListViewProtocol.swift
//  CVTTestApp
//
//  Created by Игорь on 06.05.2021.
//

import Foundation

protocol ListViewProtocol: AnyObject {
    func showDetails(with nextPresenter: DetailPresenter)
    func update()
}
