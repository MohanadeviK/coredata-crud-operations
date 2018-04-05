//
//  LicenseViewController.swift
//  CoreData-OneToOne
//
//  Created by Devi on 02/04/18.
//  Copyright © 2018 Devi. All rights reserved.
//

import UIKit
import CoreData

class LicenseViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var issuedDateTextField: UITextField!
    @IBOutlet weak var vehicleTypeTextField: UITextField!
    @IBOutlet weak var rtoOfficeNameTextfield: UITextField!
    @IBOutlet weak var expiryDateTextField: UITextField!
    @IBOutlet weak var drivingSchoolNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var fatherNameTextField: UITextField!
    
    var individualPerson : Person?
    var obId = NSManagedObjectID()
    
    enum controlType {
        case Save
        case Update
    }
    var type : controlType = .Save
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        var btn1 = UIBarButtonItem()
        if self.type == .Save {
            self.title = "New License"
            btn1 = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveBtnOnTap))
            
        }
        else {
            self.loadLicenseDetails()
            self.title = "Update Screen"
            btn1 = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(saveBtnOnTap))
            
        }
        btn1.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = btn1
        let btn2 = UIBarButtonItem(image: UIImage(named: "BackArrow.pdf"), style: .plain, target: self, action: #selector(backBtnOnTap))
        self.navigationItem.leftBarButtonItem = btn2
    }
    
    @objc func saveBtnOnTap() {
        if self.type == .Save {
            let obj = DrivingLicense.saveDetails(address: self.addressTextField.text!, drivingSchoolName: self.drivingSchoolNameTextField.text!, fatherName: self.fatherNameTextField.text!, candidateName: self.nameTextField.text!, rtoOfficeName: self.rtoOfficeNameTextfield.text!, peronObj: self.individualPerson!, dateOfBirth: self.dobTextField.text!, expiryDate: self.expiryDateTextField.text!, issuedDate: self.issuedDateTextField.text!, vehicleType: self.vehicleTypeTextField.text!)
            if obj != nil {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        else {
            let isUpdate = DrivingLicense.updateContent(name: self.nameTextField.text!, address: self.addressTextField.text!, fatherName: self.fatherNameTextField.text!, drivingSchoolName: self.drivingSchoolNameTextField.text!, updatedPersonObj: self.obId, rtoOfficeName: self.rtoOfficeNameTextfield.text!, dob: self.dobTextField.text!, issuedDate: self.issuedDateTextField.text!, vehicleType: self.vehicleTypeTextField.text!)
            if isUpdate == true {
                self.showAlert(msg: "Updated Successfully", title: "Success")
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
    
    func loadLicenseDetails() {
        if let licenseDetails = self.individualPerson?.drivinglicense {
            self.nameTextField.text = licenseDetails.name
            self.dobTextField.text = licenseDetails.dateOfBirth
            self.issuedDateTextField.text = licenseDetails.issuedDate
            self.expiryDateTextField.text = licenseDetails.expiryDate
            self.vehicleTypeTextField.text = licenseDetails.vehicleType
            self.rtoOfficeNameTextfield.text = licenseDetails.rtoOfficeName
            self.drivingSchoolNameTextField.text = licenseDetails.drivingSchoolName
            self.addressTextField.text = licenseDetails.address
            self.fatherNameTextField.text = licenseDetails.fatherName
        }
    }
    
    @objc func backBtnOnTap() {
        self.navigationController?.popViewController(animated: true)
    }
}
