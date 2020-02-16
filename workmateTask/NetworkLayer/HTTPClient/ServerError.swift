//
//  ServerError.swift
//  LearningApp
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import Foundation

struct ServerError : Codable {
    var status : String?
    var error : String?
}
