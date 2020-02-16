//
//  URLSessionExtension.swift
//  LearningApp
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import Foundation

extension URLSession : URLSessionProtocol{
    
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let task = dataTask(with : request,completionHandler : completionHandler) as URLSessionDataTask
        return task as URLSessionDataTaskProtocol
        
        
    }
    
    
}
