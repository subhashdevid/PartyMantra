//
//  Validation.swift
//  PartyMantra
//
//  Created by SUBHASH KUMAR on 29/03/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class Validation: NSObject {
    
    public func validaPhoneNumber(phoneNumber: String) -> Bool {
       let phoneNumberRegex = "^[6-9]\\d{9}$"
       let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
       let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
       let isValidPhone = validatePhone.evaluate(with: trimmedString)
       return isValidPhone
    }
    public func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
