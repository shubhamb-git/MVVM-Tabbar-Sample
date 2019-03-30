//
//  ChatViewController.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 17/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController, ChatViewModelDelegate {

    @IBOutlet var bottomInputView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtMessage: UITextField!

    var tableHeader: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 5))
        headerView.backgroundColor = .clear
        return headerView
    }()
    
    lazy var viewModel = ChatViewModel(with: self)

    // setting inputAccessoryView
    override var canBecomeFirstResponder: Bool { return true }

    override var inputAccessoryView: UIView? {
        return bottomInputView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        MessageCell.registerCell(to: tableView)
        tableView.tableHeaderView = tableHeader
        
        // fetch record from server
        activityIndicator.startAnimating()
        viewModel.getChatMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        self.txtMessage.text = ""
        self.txtMessage.resignFirstResponder()
    }
    
    //MARK: - ChatViewModelDelegate
    func didReceiveMessagesItemsFromServer() {
        DispatchQueue.main.sync {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
}


extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messagesItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return MessageCell.cell(for: tableView, at: indexPath, with: viewModel.messagesItem[indexPath.row])
    }
}
