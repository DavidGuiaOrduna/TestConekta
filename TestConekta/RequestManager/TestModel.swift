//
//  TestModel.swift
//  TestConekta
//
//  Created by David Guia on 05/04/21.
//

import UIKit
import Foundation

struct ResultModel: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}

final class TestModel {
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func validateUser() -> String {
        return "test@conekta.com"
    }
    
    func validatePassword() -> String {
        return "Abcd12345@"
    }
}
