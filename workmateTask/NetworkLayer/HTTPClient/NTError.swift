//
//  NTError.swift
//  LearningApp
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import Foundation
typealias  NTErrorHandler = (NTError?) -> Void

struct NTError : Error {
    var localizedDescription: String
    init(_ localizedDescription : String){
        self.localizedDescription = localizedDescription
    }
}
