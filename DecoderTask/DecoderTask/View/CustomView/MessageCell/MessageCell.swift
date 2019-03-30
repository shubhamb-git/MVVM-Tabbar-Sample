//
//  MessageCell.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 17/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var lblMessage: UILabel?
    @IBOutlet weak var imgUserProfile: UIImageView?
    
    var messageModel: MessageModel! {
        didSet {
            lblMessage?.text = messageModel.text! + messageModel.text! + messageModel.text!
            ImageLoader.getImagen(url: messageModel.userImageUrl) { (image) in
                self.imgUserProfile?.image = image
            }
        }
    }
    
    class func registerCell(to tableView: UITableView) {
        tableView.register(UINib(nibName: IncomingCell.stringRepresentation, bundle: nil), forCellReuseIdentifier: IncomingCell.cellId)
        
        tableView.register(UINib(nibName: OutgoingCell.stringRepresentation, bundle: nil), forCellReuseIdentifier: OutgoingCell.cellId)
    }
    
    
    static func cell(for tableView: UITableView, at indexPath: IndexPath, with item: MessageModel) -> MessageCell {
        
        switch item.messageCellView {
        case .Incoming:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IncomingCell.cellId, for: indexPath) as? IncomingCell else {
                return IncomingCell()
            }
            cell.messageModel = item
         
            return cell
        case .Outgoing:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingCell.cellId, for: indexPath) as? OutgoingCell else {
                return OutgoingCell()
            }
            cell.messageModel = item
          
            return cell
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}


