//
//  OptionsCollectionViewCell.swift
//  RadiusAssignment
//
//  Created by Kushagra Chandra on 30/06/23.
//

import UIKit

class OptionsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var icon : UIImageView!
    @IBOutlet weak var bgView : UIView!{
        didSet{
            bgView.backgroundColor = .white
            bgView.layer.borderWidth = 2.0
            bgView.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = bgView.frame.height / 2
    }
    
    private func updateAppearance() {
        if isSelected {
            // Apply selected cell appearance
            bgView.backgroundColor = .red
            bgView.layer.borderWidth = 2.0
            bgView.layer.borderColor = UIColor.blue.cgColor
        } else {
            // Apply deselected cell appearance
            bgView.backgroundColor = .white
            bgView.layer.borderWidth = 2.0
            bgView.layer.borderColor = UIColor.blue.cgColor
        }
    }
}
