//
//  RequestProtocol.swift
//  LearningApp
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String : String]


protocol RequestProtocol {
    var baseURL : URL { get }
    var path : String { get }
    var httpMethod : HTTPMethod { get }
    var httpBody : Data? { get }
    var httpHeaders : HTTPHeaders? { get }
}
