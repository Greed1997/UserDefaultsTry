//
//  StorageManager.swift
//  UserDefaultsTextTry
//
//  Created by Александр on 03.10.2022.
//

import Foundation

// StorageManager - сервис, который управляет хранилищем(добавить, удалить, редактировать)
// DataManager - хранилище для хранения данных
class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let textKey = "text"
    private let personKey = "person"
    
    private init() {}
    
    func save(text: String) {
        var texts = fetchText()
        texts.append(text)
        userDefaults.set(texts, forKey: textKey)
    }
    func save(person: Person) {
        var people = fetchPeople()
        people.append(person)
        guard let data = try? JSONEncoder().encode(people) else { return }
        userDefaults.set(data, forKey: personKey)
    }
    
    func fetchText() -> [String] {
        if let texts = userDefaults.value(forKey: textKey) as? [String] {
            return texts
        }
        return []
    }
    func fetchPeople() -> [Person] {
        guard let data = userDefaults.object(forKey: personKey) as? Data else { return [] }
        guard let people = try? JSONDecoder().decode([Person].self, from: data) else { return [] }
        return people
    }
    func deleteText(at index: Int) {
        var texts = fetchText()
        texts.remove(at: index)
        userDefaults.set(texts, forKey: textKey)
    }
    func deletePerson(at index: Int) {
        var people = fetchPeople()
        people.remove(at: index)
        guard let data = try? JSONEncoder().encode(people) else { return }
        userDefaults.set(data, forKey: personKey)
    }
    
}
