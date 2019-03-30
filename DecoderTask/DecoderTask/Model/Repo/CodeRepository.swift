//
//  CodeRepository.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation

enum CodeDataResponse {
    case success(result: [CodeModel])
    case failure
}

class CodeRepsository: BaseService {
    
    func getCodeList(with completion: @escaping (CodeDataResponse) -> Void ) {
   
        let endPoint = CodeEndPoint.getCode
        super.callEndPoint(endPoint: endPoint.rawValue) { (response: ServiceResponse<[CodeModel]>) in
          
            switch response {
            case .success(let result):
                completion(.success(result: result))
            default:
                completion(.failure)
            }
        }
    }
}
