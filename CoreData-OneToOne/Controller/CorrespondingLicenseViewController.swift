//
//  CorrespondingLicenseViewController.swift
//  CoreData-OneToOne
//
//  Created by Devi on 04/04/18.
//  Copyright © 2018 Devi. All rights reserved.
//

import UIKit
import CoreData

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
    
    var individualPerson : Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "License Screen"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getDrivingLicenseDetails()
        self.navigationController?.navigationBar.isHidden = false
        let btn2 = UIBarButtonItem(image: UIImage(named: "BackArrow.pdf"), style: .plain, target: self, action: #selector(backBtnOnTap))
        self.navigationItem.leftBarButtonItem = btn2
    }
    
    @objc func addBtnOnTap() {
        let licenseVC = self.storyboard?.instantiateViewController(withIdentifier: "LicenseViewController") as? LicenseViewController
        licenseVC?.type = .Save
        if let person = self.individualPerson {
            licenseVC?.individualPerson = person
        }
        self.navigationController?.pushViewController(licenseVC!, animated: true)
    }
    
    @objc func backBtnOnTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDrivingLicenseDetails()  {
        if let person = individualPerson?.drivinglicense {
            self.noRecordsFoundLbl.isHidden = true
            let btn1 = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            self.navigationItem.rightBarButtonItem = btn1
            self.superView.isHidden = false
            self.scrlView.isScrollEnabled = true
            self.nameLbl.text = person.name
            self.fatherNameLbl.text = person.fatherName
            self.addressLBl.text = person.address
            self.rtoNameLbl.text = person.rtoOfficeName
            self.dobLbl.text = person.dateOfBirth
            self.issuedDateLbl.text = person.issuedDate
            self.expiryDateLbl.text = person.expiryDate
            self.vehicleTypeLbl.text = person.vehicleType
            self.drivingSchoolNameLbl.text = person.drivingSchoolName
        }
        else {
            self.noRecordsFoundLbl.isHidden = false
            self.setRightBarButtonItem()
            self.self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.superView.isHidden = true
            self.scrlView.isScrollEnabled = false
        }
    }
    
    @IBAction func editBtnOnTap(_ sender: UIButton) {
        let licenseVc = self.storyboard?.instantiateViewController(withIdentifier: "LicenseViewController") as? LicenseViewController
        licenseVc?.individualPerson = self.individualPerson
        if let licenseObjId = self.individualPerson?.drivinglicense {
            licenseVc?.obId = licenseObjId.objectID
        }
        licenseVc?.type = .Update
        self.navigationController?.pushViewController(licenseVc!, animated: true)
    }
    
    @IBAction func deleteBtnOnTap(_ sender: UIButton) {
        if let license = self.individualPerson?.drivinglicense {
            let flag = DrivingLicense.deleteOperation(license: license)
            if flag == true {
                self.showAlert(msg: "Deleted successfully!", title: "")
            }
        }
    }
    
    func showAlert(msg : String, title : String)
    {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            action -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        self.present(alertController, animated: true)
        {}
    }
    
    func setRightBarButtonItem() {
        let btn1 = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBtnOnTap))
        btn1.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = btn1
    }
}
