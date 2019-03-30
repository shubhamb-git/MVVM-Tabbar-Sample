//
//  AppConstants.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation
//http://dcoder.tech/test_json/chat.json

struct AppConstants {
    
    static private let protocolo    : String = "http://"
    static private let domain       : String = "dcoder.tech"
    static private let apiPath      : String = "/test_json"
    static let baseUrl      : String = protocolo + domain + apiPath
    
    struct TabBarItems {
        
        struct  DevChats {
            static let name =  "DevChatViewController"
            static let imageEnbled = "DevChatEnabled"
            static let imageDisabled = "DevChatDisabled"
        }
        
        struct Thread {
            static let name =  "ThreadViewController"
            static let imageEnbled = "ThreadEnabled"
            static let imageDisabled = "ThreadDisabled"
        }
        
        struct  QnA {
            static let name =  "QAViewController"
            static let imageEnbled = "QAEnabled"
            static let imageDisabled = "QADisabled"
        }
        
        struct Code {
            static let name =  "CodeViewController"
            static let imageEnbled = "CodeEnabled"
            static let imageDisabled = "CodeDisabled"
        }
    }
}
