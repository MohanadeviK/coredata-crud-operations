//
//  LicenseViewController.swift
//  CoreData-OneToOne
//
//  Created by Devi on 02/04/18.
//  Copyright © 2018 Devi. All rights reserved.
//

import UIKit

class LicenseViewController: UIViewController {
    
    @IBOutlet weak var notFoundLbl: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var issuedDateTextField: UITextField!
    @IBOutlet weak var vehicleTypeTextField: UITextField!
    @IBOutlet weak var rtoOfficeNameTextfield: UITextField!
    @IBOutlet weak var expiryDateTextField: UITextField!
    @IBOutlet weak var drivingSchoolNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var fatherNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.fetchLicenseDetails()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "License Screen"
        let btn1 = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBtnOnTap))
        btn1.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = btn1
        let btn2 = UIBarButtonItem(image: UIImage(named: "BackArrow.pdf"), style: .plain, target: self, action: #selector(backBtnOnTap))
        self.navigationItem.leftBarButtonItem = btn2
    }
    
    @objc func addBtnOnTap() {
       
    }
    
//    func fetchLicenseDetails() {
//        if () {
//          self.notFoundLbl.isHidden = false
//        }
//        else {
//            self.notFoundLbl.isHidden = true
//            self.nameTextField.text =
//        }
//    }
    
    @objc func backBtnOnTap() {
        self.navigationController?.popViewController(animated: true)
    }
}