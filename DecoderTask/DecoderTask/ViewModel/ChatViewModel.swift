//
//  CodeViewModel.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation

protocol ChatViewModelDelegate: class {
    func didReceiveMessagesItemsFromServer()
}

class ChatViewModel {
    
    lazy var messagesItem = [MessageModel]()
    var repository: ChatRepsository?
    weak var delegate: ChatViewModelDelegate?
    
    init(with delegate: ChatViewModelDelegate) {
        self.delegate = delegate
        repository = ChatRepsository()
    }
    
    func getChatMessages() {
        guard let repo = repository else { return }
        
        repo.getChatMessages { [weak self](response) in
            guard let strongSelf = self else { return }
            
            switch response {
            case .success(let result):
                strongSelf.messagesItem = result
                strongSelf.delegate?.didReceiveMessagesItemsFromServer()
            case.failure:
                break
            }
        }
    }
}
