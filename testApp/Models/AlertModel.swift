//
//  AlertModel.swift
//  testApp
//
//  Created by Артём Костянко on 13.10.23.
//

import Foundation

struct AlertModel {
    var title: String
    var message: String
    var buttonText: String
    var completion: () -> Void
}
