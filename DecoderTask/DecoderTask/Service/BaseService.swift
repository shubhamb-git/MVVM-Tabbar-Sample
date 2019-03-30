//
//  BaseService.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceResponse<T: Codable> {
    case success(response: T)
    case failure
    case notConnectedToInternet
}

enum ResponseStatusCode: Int {
    case success = 200
}

class BaseService {
    
    var dataRequestArray: [DataRequest] = []
    var sessionManager: [String : Alamofire.SessionManager] = [:]
    
    internal func callEndPoint<T: Codable>(endPoint: String, method: Alamofire.HTTPMethod = .get, headers: [String:String]? = [:], params: [String:Any]? = [:], completion: @escaping (ServiceResponse<T>) -> Void){
        
        let url = AppConstants.baseUrl + endPoint 
        
        let dataRequest: DataRequest!
        
        switch method {
        case .post:
            dataRequest = request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseData(completionHandler: { (response) in
                self.serializeResponse(response: response, completion: completion)
                self.sessionManager.removeValue(forKey: url)
            })
        default:
            dataRequest = request(url, method: method, parameters: params, headers: headers).responseData(completionHandler: { (response) in
                    self.serializeResponse(response: response, completion: completion)
                    self.sessionManager.removeValue(forKey: url)
                })
        }
        dataRequestArray.append(dataRequest)
    }
    
    func serializeResponse<T>(response: Alamofire.DataResponse<Data>,  completion: @escaping (ServiceResponse<T>) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            guard let _ = response.response else {
                if let error = response.result.error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                    completion(.notConnectedToInternet)
                } else {
                    completion(.failure)
                }
                return
            }
            
            if let data = response.data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    let decoder = JSONDecoder()
                    let decodedValue = try decoder.decode(T.self, from: data)
                    completion(.success(response: decodedValue))
                    return
                }catch {
                    print(error)
                    completion(.failure)
                    return
                }
            }
        }
    }
    
    func cancelAllRequests () {
        for dataRequest in self.dataRequestArray {
            dataRequest.cancel()
        }
        self.dataRequestArray.removeAll()
    }
}

