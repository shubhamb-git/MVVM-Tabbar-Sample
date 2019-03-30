//
//  ChatRepsository.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 17/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation

enum ChatDataResponse {
    case success(result: [MessageModel])
    case failure
}

class ChatRepsository: BaseService {
    
    func getChatMessages(with completion: @escaping (ChatDataResponse) -> Void ) {
        
        let endPoint = DevChatEndPoint.getChat
        super.callEndPoint(endPoint: endPoint.rawValue) { (response: ServiceResponse<[MessageModel]>) in
            
            switch response {
            case .success(let result):
                completion(.success(result: result))
            default:
                completion(.failure)
            }
        }
    }
}
