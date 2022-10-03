//
//  ViewController.swift
//  UserDefaultsTextTry
//
//  Created by Александр on 03.10.2022.
//

import UIKit
protocol SetPersonDelegate {
    func setPerson(_ person: Person)
}
class ViewController: UITableViewController {

    private var cellID = "cell"
    private var people: [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        people = StorageManager.shared.fetchPeople()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Title"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewPerson)
        )
        navigationController?.navigationBar.tintColor = .white
        
        navBarAppearance.backgroundColor = UIColor(red: 0.1, green: 0.7, blue: 0.3, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    @objc private func addNewPerson() {
        let addPersonVC = AddPersonVC()
        addPersonVC.delegate = self
        present(addPersonVC, animated: true)
    }
}
// MARK: - UITableViewDataSource
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let person = people[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = person.fullName
        cell.contentConfiguration = content
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StorageManager.shared.deletePerson(at: indexPath.row)
            people.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
extension ViewController: SetPersonDelegate {
    func setPerson(_ person: Person) {
        people.append(Person(name: person.name, surname: person.surname))
        tableView.reloadData()
    }
}
