//
//  HttpClient.swift
//  LearningApp
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import Foundation

class HttpClient {
    
    // MARK:- Typealias  ----> it Give an alertnative name for existing Type
    
    /* result -- > A value that represents either a success or a failure, including an associated value in each case.*/
    typealias CompeltionResult = (Result<Data?,NTError>) -> Void
    
    static let shared = HttpClient(session: URLSession.shared)
    
    // MARK:- Custom Property
    private let session : URLSessionProtocol
    private var task : URLSessionDataTaskProtocol?
    private var completionResult : CompeltionResult?
    
    // MARK: - Initialiser
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func dataTask(_ request : RequestProtocol, completion : @escaping CompeltionResult){
        completionResult = completion
        var urlRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: Constants.Service.timeOut)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.httpBody
        urlRequest.allHTTPHeaderFields = request.httpHeaders
        task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let error = error {
                self.completionResult!(.failure(NTError(error.localizedDescription)))
                return
            }
           
            if let response = response as? HTTPURLResponse{
                let httpStatusCode = response.statusCode
                if httpStatusCode == 204{
                    self.completionResult!(.success(nil))
                }
                if httpStatusCode == 400 {
                    CommonDatas.errcode = 400
                    self.completionResult!(.failure(NTError("400")))
                }
                if let data = data {
                    self.completionResult!(.success(data))
                }
                print("httpStatusCode : \(httpStatusCode)")
                
            }else{
                let commonErrorMessage = NSLocalizedString("Something went wrong!", comment : "")
                guard let data = data else {
                    self.completionResult!(.failure(NTError(commonErrorMessage)))
                    return
                }
                do{
                    let serverError =  try JSONDecoder().decode(ServerError.self, from: data)
                    print("Server Error : \(serverError)")
                    self.completionResult!(.failure(NTError(commonErrorMessage)))
                }catch{
                    self.completionResult!(.failure(NTError(commonErrorMessage)))
                }
            }
            
        })
        self.task?.resume()
    }
    func cancel(){
        self.task?.cancel()
    }
    //MARK:- private Completion function
    private func CompeltionResult(_ result : Result<Data?,NTError>){
        DispatchQueue.main.async {
            self.completionResult?(result)
        }
    }
}
