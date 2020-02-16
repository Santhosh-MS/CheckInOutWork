//
//  ContactService.swift
//  LearningApp
//
//  Created by Ducont on 16/02/20.
//  Copyright © 2020 Ducont. All rights reserved.
//

import Foundation

enum ContactAPI {
    case Login(urlPath : String ,userLogin : [String : String])
    case TechDetails(UrlMethod : String)
    case CheckInCheckOut(urlPath : String ,paraData : [String : String])
}

extension ContactAPI : RequestProtocol{
    var httpMethod: HTTPMethod {
        switch self{
        case .Login :
        return .post
        case .TechDetails :
        return .get
        case .CheckInCheckOut :
        return .post
        }
    }
    
var baseURL: URL {
        guard let url = URL(string: Constants.Service.baseurl) else{
            fatalError("BaseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self{
        case .Login(let urlPath,  _) :
            return "\(String(describing: urlPath))"
        case .TechDetails(let urlMeth) :
            return "\(String(describing: urlMeth))"
        case .CheckInCheckOut(let urlPath,  _) :
            return "\(String(describing: urlPath))"
        }
    }
    
    var httpHeaders: HTTPHeaders? {
          var header : [String : String] = [:]
        switch self{
                case .Login(_ ,_) :
                    header.updateValue("application/json", forKey: "Content-Type")
                    return header
        case .TechDetails,.CheckInCheckOut :
                    header.updateValue("application/json", forKey: "Content-Type")
                    header.updateValue("token \(String(describing: Constants.Service.AccessToken))", forKey: "Authorization")
                    return header
            }
    }
    var httpBody: Data? {
         switch self{
         case .Login(_ ,let userLogin):
            do {
                let data = try JSONSerialization.data(withJSONObject: userLogin, options: .prettyPrinted)
                return data
            }catch {
                return nil
            }
         case  .TechDetails:
            return nil
            case .CheckInCheckOut(_,let paraData) :
            do {
                let data = try JSONSerialization.data(withJSONObject: paraData, options: .prettyPrinted)
                return data
            }catch {
                return nil
            }
        }
    }
}
