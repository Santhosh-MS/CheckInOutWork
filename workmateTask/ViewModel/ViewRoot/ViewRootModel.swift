//
//  ViewRootModel.swift
//  workmateTask
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import Foundation

protocol getDetailsTechInfoDelegate {
    func TechInfoServiceDetails(infoTech : Techdetails ) -> Void
}

class ViewRootModel {
    private var httpClient : HttpClient!
    
    var rootViewDelegate : getDetailsTechInfoDelegate?
    init(client : HttpClient? = nil ){
        self.httpClient = client ?? HttpClient.shared
    }
    
    public func getLoginDetails(){
    var loginData : [String : String] = [:]
    loginData.updateValue("+6281313272005", forKey: "username")
    loginData.updateValue("alexander", forKey: "password")
            
        httpClient.dataTask(ContactAPI.Login(urlPath: "auth/login/", userLogin: loginData)){ [weak self] (result) in
            guard self != nil else{
                return
            }
                switch result {
                case .success(let data):
                    guard let data = data else{
                        return
                    }
                    print("data : \(data)")
                    do{
                        let key : [String:String] = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : String]
                        Constants.Service.AccessToken = key["key"]!
                        if Constants.Service.AccessToken != nil {
                            self?.getTechInfo()
                        }else {
                            print("Token not yet return")
                        }
                        
                    }catch let err as NSError {
                        print("err : \(err.localizedDescription)")
                    }
                case .failure(let error):
                    print("Error in fetching Constant : \(error) ")
                }
            }
        
        }
    
    
    
    func getTechInfo() -> Void{
    httpClient.dataTask(ContactAPI.TechDetails(UrlMethod: "staff-requests/26074/")){ [weak self] (result) in
        guard self != nil else{
                    return
                }
                switch result {
                case .success(let data):
                    guard let data = data else{
                        return
                    }
                    print("data : \(data)")
                    
                    DispatchQueue.main.async(execute: {
                        do{
                           let decoder = JSONDecoder()
                            let techdetails = try decoder.decode(Techdetails.self, from: data)
            self?.rootViewDelegate?.TechInfoServiceDetails(infoTech: techdetails)
                        }catch let err as NSError {
                            print("err : \(err.localizedDescription)")
                }
        })
                case .failure(let error):
                    print("Error in fetching Constant : \(error) ")
                }
            }
        
        }
    
}
