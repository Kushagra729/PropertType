//
//  ViewController.swift
//  RadiusAssignment
//
//  Created by Kushagra Chandra on 29/06/23.
//

import UIKit

class ViewController: UIViewController {
    var facilities = [Facility]()
    var exclusion = [[Exclusion]]()
    var propertTypeSelected = false
    
    @IBOutlet weak var facilityTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
        facilityTableView.register(UINib(nibName: "FacilityTableViewCell", bundle: nil), forCellReuseIdentifier: "FacilityTableViewCell")
        facilityTableView.delegate = self
        facilityTableView.dataSource = self
        
    }
    
    func callAPI() {
        APIServices.shared.apiToGetPropertyData { Property in
            print(Property)
            self.facilities = Property.facilities
            self.exclusion = Property.exclusions
            DispatchQueue.main.async {
                self.facilityTableView.reloadData()
            }
        }
    }
    
    func performExclusions(exclusions: [[Exclusion]],selectedFacilityId: String, selectedOptionId: Int){
        for exclusion in exclusions {
            print(exclusion)
            if selectedFacilityId == exclusion[0].facilityID && selectedOptionId == Int(exclusion[0].optionsID){
                
                for facility in 0...facilities.count - 1 {
                    if facilities[facility].facilityID == exclusion[0].facilityID {
                        for opt in 0...facilities[facility].options.count - 1{
                            if facilities[facility].options[opt].id == exclusion[0].optionsID {
                                facilities[facility].options.remove(at: opt)
                                facilityTableView.reloadData()
                            }
                        }
                    }
                }
            }else{
                facilityTableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if facilities.count > 0{
            if propertTypeSelected {
                return facilities.count
            }else{
                return 1
            }
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FacilityTableViewCell", for: indexPath) as! FacilityTableViewCell
        cell.facility = facilities[indexPath.section]
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return facilities[section].name
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
extension ViewController: FacilityTableViewCellDelegate{
    func propertyTypeSelected(selectedFacilityId: String, selectedOptionId: Int) {
        propertTypeSelected = true
        performExclusions(exclusions: exclusion, selectedFacilityId: selectedFacilityId, selectedOptionId: selectedOptionId)
    }
}

