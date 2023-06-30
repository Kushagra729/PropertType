//
//  FacilityTableViewCell.swift
//  RadiusAssignment
//
//  Created by Kushagra Chandra on 29/06/23.
//

import UIKit

//MARK: - Protocol

protocol FacilityTableViewCellDelegate {
    func propertyTypeSelected(selectedFacilityId:String, selectedOptionId: Int)
}

class FacilityTableViewCell: UITableViewCell {
    
//MARK: - Outlet(s)
    @IBOutlet weak var optionsCV: UICollectionView!
    
    var delegate : FacilityTableViewCellDelegate?
    var facility : Facility!
    var exclusions = [[Exclusion]]()
    var selectedIndexPath: IndexPath? = nil
    
 //MARK: - Override Method(s)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        optionsCV.register(UINib(nibName: "OptionsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OptionsCollectionViewCell")
        optionsCV.delegate = self
        optionsCV.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}

//MARK: - Extention(s)

extension FacilityTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return facility.options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionsCollectionViewCell", for: indexPath) as! OptionsCollectionViewCell
        
        cell.name.text = facility.options[indexPath.item].name
        cell.icon.image = UIImage(named: facility.options[indexPath.item].icon)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.facility.options[indexPath.item].name as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)])
        return CGSize(width: size.width + 150, height: size.height + 25.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if Int(facility.facilityID) == 1 {
            delegate?.propertyTypeSelected(selectedFacilityId: facility.facilityID, selectedOptionId: Int(facility.options[indexPath.row].id) ?? 0)
            
        }
    }
}

