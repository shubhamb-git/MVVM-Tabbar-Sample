//
//  CodeViewModel.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import Foundation

protocol CodeViewModelDelegate: class {
    func didReceiveCodeItemsFromServer()
}

class CodeViewModel {
    
    lazy var codeItems = [CodeModel]()
    var repository: CodeRepsository?
    weak var delegate: CodeViewModelDelegate?
    
    init(with delegate: CodeViewModelDelegate) {
        self.delegate = delegate
        repository = CodeRepsository()
    }
    
    func getCode() {
        guard let repo = repository else { return }
        
        repo.getCodeList { [weak self](response) in
            guard let strongSelf = self else { return }
            
            switch response {
            case .success(let result):
                strongSelf.codeItems = result
                strongSelf.delegate?.didReceiveCodeItemsFromServer()
            case.failure:
                break
            }
        }
    }
}
