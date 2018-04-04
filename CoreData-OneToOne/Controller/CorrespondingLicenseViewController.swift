//
//  CorrespondingLicenseViewController.swift
//  CoreData-OneToOne
//
//  Created by Devi on 04/04/18.
//  Copyright © 2018 Devi. All rights reserved.
//

import UIKit

class CorrespondingLicenseViewController: UIViewController {
    
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var fatherNameLbl: UILabel!
    @IBOutlet weak var issuedDateLbl: UILabel!
    @IBOutlet weak var vehicleTypeLbl: UILabel!
    @IBOutlet weak var rtoNameLbl: UILabel!
    @IBOutlet weak var expiryDateLbl: UILabel!
    @IBOutlet weak var drivingSchoolNameLbl: UILabel!
    @IBOutlet weak var addressLBl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var noRecordsFoundLbl: UILabel!
    
    var individualPerson = Person()
    var licenseDetails = DrivingLicense()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "License Screen"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.getDrivingLicenseDetails()
        let btn2 = UIBarButtonItem(image: UIImage(named: "BackArrow.pdf"), style: .plain, target: self, action: #selector(backBtnOnTap))
        self.navigationItem.leftBarButtonItem = btn2
    }
    
    @objc func addBtnOnTap() {
        let licenseVC = self.storyboard?.instantiateViewController(withIdentifier: "LicenseViewController") as? LicenseViewController
        licenseVC?.individualPerson = self.individualPerson
        self.navigationController?.pushViewController(licenseVC!, animated: true)
    }
    
    @objc func backBtnOnTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDrivingLicenseDetails()  {
        if let lDetails = DrivingLicense.fetchDetails(selectedPerson: self.individualPerson) {
            self.noRecordsFoundLbl.isHidden = true
            let btn1 = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            self.navigationItem.rightBarButtonItem = btn1
            self.superView.isHidden = false
            self.scrlView.isScrollEnabled = true
            self.nameLbl.text = lDetails.name
            self.fatherNameLbl.text = lDetails.fatherName
            self.addressLBl.text = lDetails.address
            self.rtoNameLbl.text = lDetails.rtoOfficeName
            self.drivingSchoolNameLbl.text = lDetails.drivingSchoolName
        }
        else {
            self.noRecordsFoundLbl.isHidden = false
            self.setRightBarButtonItem()
            self.self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.superView.isHidden = true
            self.scrlView.isScrollEnabled = false
        }
    }
    
    func setRightBarButtonItem() {
        let btn1 = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBtnOnTap))
        btn1.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = btn1
    }
}
