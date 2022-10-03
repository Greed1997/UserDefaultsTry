//
//  Person.swift
//  UserDefaultsTextTry
//
//  Created by Александр on 03.10.2022.
//

import Foundation

struct Person: Codable {
    let name: String
    let surname: String
    
    var fullName: String {
        "\(name) \(surname)"
    }
}
