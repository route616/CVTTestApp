//
//  ListViewController.swift
//  CVTTestApp
//
//  Created by Игорь on 05.05.2021.
//

import UIKit

final class ListViewController: UITableViewController {
    private var presenter = ListPresenter()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.setView(view: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.loadStudentList()
    }

    // MARK: Actions
    @IBAction func pushAddButton(_ sender: UIButton) {
        presenter.showDetails()
        presenter.loadStudentList()
    }
}

// MARK: - UITableViewDelegate
extension ListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showDetails(row: indexPath.row)
    }
}

// MARK: - UITableViewDataSource
extension ListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.studentCount
    }

    override func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        presenter.configure(cell: cell, row: indexPath.row)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            presenter.deleteStudent(with: indexPath.row)
        }
    }
}

// MARK: - ListViewControllerProtocol
extension ListViewController: ListViewProtocol {
    func showDetails(with nextPresenter: DetailPresenter) {
        let detailViewController = DetailViewController.`init`(with: nextPresenter)
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func update() {
        tableView.reloadData()
    }
}
