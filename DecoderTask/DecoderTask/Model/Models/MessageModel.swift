//
//  MessageModel.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 17/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation

enum MessageCellView {
    case Incoming
    case Outgoing
    // if image or video we can add more cell here
}

class MessageModel: Codable {
    
    var userName: String?
    var userImageUrl: String?
    var isSentByMe: Bool?
    var text: String?
    
    var messageCellView: MessageCellView {
        if isSentByMe ?? false {
            return .Outgoing
        }
        return .Incoming
    }
    
    private enum CodingKeys: String, CodingKey {
        case user_name
        case user_image_url
        case is_sent_by_me
        case text
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userName, forKey: .user_name)
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userName = try values.decode(String?.self, forKey: .user_name)
        userImageUrl = try values.decode(String?.self, forKey: .user_image_url)
        isSentByMe = try values.decode(Bool?.self, forKey: .is_sent_by_me)
        text = try values.decode(String?.self, forKey: .text)
    }
}
