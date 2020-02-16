//
//  URLSessionProtocol.swift
//  LearningApp
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request : URLRequest,completionHandler : @escaping (Data?,URLResponse?,Error?) -> Void) -> URLSessionDataTaskProtocol 
//    func LoginGetToken(with request : URLRequest,completionHandler : @escaping (Data?,URLResponse?,Error?) -> Void) -> URLSessionDataTaskProtocol
}
