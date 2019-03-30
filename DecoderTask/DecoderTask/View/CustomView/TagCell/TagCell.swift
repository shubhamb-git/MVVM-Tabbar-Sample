//
//  TagCell.swift
//  DecoderTask
//
//  Created by Shubham bairagi on 17/02/19.
//  Copyright © 2019 SB. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {

    static let cellId = "TagCell"
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblTag: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewContainer.layer.cornerRadius = 10
        viewContainer.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        viewContainer.layer.borderWidth = 0.7
        viewContainer.layer.masksToBounds = true
    }
    
    class func registerCell(to collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: TagCell.stringRepresentation, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    static func cell(for collectioView: UICollectionView, at indexPath: IndexPath, with item: String?) -> TagCell {
        guard let cell = collectioView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? TagCell else {
            return TagCell()
        }
        cell.lblTag.text = item
        return cell
    }
    
}
