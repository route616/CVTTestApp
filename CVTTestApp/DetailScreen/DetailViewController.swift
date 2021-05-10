//
//  DetailViewController.swift
//  CVTTestApp
//
//  Created by Игорь on 05.05.2021.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var averageScoreTextField: UITextField!

    private var presenter: DetailPresenter!

    private var activeTextField: UITextField? = nil

    static func `init`(with presenter: DetailPresenter) -> DetailViewController {
        let detailViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "DetailViewController")
        as! DetailViewController
        detailViewController.presenter = presenter
        return detailViewController
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Student"

        presenter.setView(view: self)
        presenter.loadStudent()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: Magic tricks
    private func showAlert(with title: String, and description: String) {
        let alertController = UIAlertController(
            title: title, message: description, preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "Change", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }

    @objc private func keyboardWillShow(sender: NSNotification) {
        guard let keyboardSize = (
                sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
        )?.cgRectValue else { return }

        if let activeTextField = activeTextField {
            let bottomTextField = activeTextField.convert(activeTextField.bounds, to: view).maxY
            let topOfKeyboard = view.frame.height - keyboardSize.height
            if bottomTextField > topOfKeyboard {
                view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc private func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
    }

    // MARK: Actions
    @IBAction func pushSaveButton(_ sender: UIButton) {
        presenter.save()
    }

    @IBAction func pushCancelButton(_ sender: UIButton) {
        presenter.cancel()
    }

    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        view.endEditing(true)
    }
}

// MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    var firstName: String? {
        get {
            return firstNameTextField.text
        }
        set {
            firstNameTextField.text = newValue
        }
    }

    var lastName: String? {
        get {
            return lastNameTextField.text
        }
        set {
            lastNameTextField.text = newValue
        }
    }

    var averageScore: Double? {
        get {
            if let text = averageScoreTextField.text {
                return Double(text)
            } else {
                return nil
            }
        }
        set {
            if let value = newValue {
                averageScoreTextField.text = String(value)
            }
        }
    }

    func showInvalidNameAlert() {
        showAlert(with: "Invalid name", and: "Please enter a valid name. It must contain letters of the Russian and English alphabets and not have spaces.")
    }

    func showInvalidScoreAlert() {
        showAlert(with: "Invalid score", and: "Please enter an integer number between 1 and 5.")
    }

    func backToList() {
        navigationController?.popViewController(animated: true)
        print("Call: backToList()")
    }
}

// MARK: - UITextFieldDelegate
extension DetailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}
