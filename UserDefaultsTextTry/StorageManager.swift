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
    private let key = "key"
    
    private init() {}
    
    func save(text: String) {
        var texts = fetchText()
        texts.append(text)
        userDefaults.set(texts, forKey: key)
    }
    
    func fetchText() -> [String] {
        if let texts = userDefaults.value(forKey: key) as? [String] {
            return texts
        }
        return []
    }
}
