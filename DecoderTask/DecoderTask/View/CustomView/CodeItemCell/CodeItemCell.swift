//
//  CodeItemCell.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 16/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class CodeItemCell: UITableViewCell {

    static let cellId = "CodeItemCell"
    
    //MARK: @IBOutlets
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var lblCodeTitle: UILabel!
    @IBOutlet weak var lblCodeLanguage: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var btnComments: UIButton!
    @IBOutlet weak var btnLikes: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tagCollection: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!

    //MARK: Properties
    var codeModel: CodeModel! {
        didSet {
            lblCodeTitle.text = codeModel.title
            lblUserName.text = "By \(codeModel.userName ?? "Anonymous")"
            lblTime.text = codeModel.timeCreatedAsDate?.timeAgoSinceNow
            lblCode.text = codeModel.code
            btnComments.setTitle(codeModel.commentString, for: .normal)
            btnLikes.setTitle(codeModel.upvoteString, for: .normal)
           
            activityIndicator.startAnimating()
            ImageLoader.getImagen(url: codeModel.userImageUrl) { (image) in
                self.imgUserProfile.image = image
                self.activityIndicator.stopAnimating()
            }
            tagCollection.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.collectionViewHeight.constant = self.tagCollection.contentSize.height
                self.layoutIfNeeded()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // collectionview cell register
        TagCell.registerCell(to: tagCollection)
    }
    
    class func registerCell(to tableView: UITableView) {
        tableView.register(UINib(nibName: CodeItemCell.stringRepresentation, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    static func cell(for tableView: UITableView, at indexPath: IndexPath, with item: CodeModel) -> CodeItemCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CodeItemCell else {
            return CodeItemCell()
        }
        cell.selectionStyle = .none
        cell.codeModel = item
        return cell
    }
}

extension CodeItemCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return codeModel.tags?.count ?? 0
    }
    
    ///Custom cell for collection view , show data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return TagCell.cell(for: collectionView, at: indexPath, with: codeModel.tags?[indexPath.item])
    }
}

extension CodeItemCell: UICollectionViewDelegateFlowLayout {
    ///Set  size of the cell for collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let string = codeModel.tags?[indexPath.item] else {
            return CGSize(width: 10, height: 20)
        }

        let width = string.width(withConstrainedHeight: 20, font: lblCodeLanguage.font)
        return CGSize(width: width + 10, height: 20)
    }
}
