//
//  AddPerson.swift
//  UserDefaultsTextTry
//
//  Created by Александр on 03.10.2022.
//

import UIKit

class AddPersonVC: UIViewController {
    var delegate: SetPersonDelegate?
    
    private lazy var nameTextField: UITextField = { // lazy - откладывает инициализацию свойств; свойство работает как только мы к нему обратимся
       let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private lazy var surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Surname"
        textField.borderStyle = .roundedRect
        return textField
    }()
    private lazy var saveButton = CustomButton(title: "Save", color: .systemBlue)
    private lazy var cancelButton = CustomButton(title: "Cancel", color: .systemRed)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        setupSubviews(nameTextField, surnameTextField, saveButton, cancelButton)
        // Set constraints
        setNameTFConstraints()
        setSurnameTFConstraints()
        setSaveButtonConstraints()
        setCancelButtonConstraints()
    }
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    private func setNameTFConstraints() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    private func setSurnameTFConstraints() {
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    private func setSaveButtonConstraints() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    private func setCancelButtonConstraints() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    @objc private func save() {
        guard let name = nameTextField.text else {
            dismiss(animated: true)
            return
        }
        StorageManager.shared.save(person: Person(name: name, surname: surnameTextField.text ?? ""))
        delegate?.setPerson(Person(name: name, surname: surnameTextField.text ?? ""))

        dismiss(animated: true)
    }
    @objc private func cancel() {
        dismiss(animated: true)
    }
//    private func setNSLayoutConstraint<T>(for views: T..., and constants: [Int]) where T: UIView {
//        views.forEach { view in
//            view.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                view.topAnchor.constraint(equalTo: view, constant: <#T##CGFloat#>)
//            ])
//        }
//        NSLayoutConstraint.activate([
//            view.topAnchor
//        ])
//    }
}
extension AddPersonVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    @objc private func doneButton() {
        view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        textField.inputAccessoryView = keyboardToolBar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButton)
        )
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        keyboardToolBar.items = [flexBarButton, doneButton]
    }
}
