//
//  CodeModel.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation

class CodeModel: Codable {
    
    var userName: String?
    var userImageUrl: String?
    var time: String? // timestamp
    var tags: [String]?
    var title: String?
    var code: String?
    var codeLanguage: String?
    var upvotes: Int?
    var downvotes: Int?
    var comments: Int?
    
    var commentString: String {
        if let comments = comments {
            if comments > 1 {
                return "\(comments) Comments"
            }
            return "\(comments) Comment"
        }
        return "0 Comment"
    }
    
    var upvoteString: String {
        if let upvotes = upvotes {
            if upvotes > 1 {
                return "\(upvotes) Likes"
            }
            return "\(upvotes) Like"
        }
        return "0 Like"
    }
    
    var timeCreatedAsDate: Date? {
        if let time = time, let asDouble = Double(time) {
            return Date(timeIntervalSince1970: asDouble)
        }
        return nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case user_name
        case user_image_url
        case time
        case tags
        case title
        case code
        case code_language
        case upvotes
        case downvotes
        case comments
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userName = try values.decode(String?.self, forKey: .user_name)
        userImageUrl = try values.decode(String?.self, forKey: .user_image_url)
        time = try values.decode(String?.self, forKey: .time)
        tags = try values.decode([String]?.self, forKey: .tags)        
        title = try values.decode(String?.self, forKey: .title)
        code = try values.decode(String?.self, forKey: .code)
        codeLanguage = try values.decode(String?.self, forKey: .code_language)
        upvotes = try values.decode(Int?.self, forKey: .upvotes)
        downvotes = try values.decode(Int?.self, forKey: .downvotes)
        comments = try values.decode(Int?.self, forKey: .comments)
    }
}
