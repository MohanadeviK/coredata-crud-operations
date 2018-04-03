//
//  AddNewPersonViewController.swift
//  CoreData-OneToOne
//
//  Created by Devi on 02/04/18.
//  Copyright © 2018 Devi. All rights reserved.
//

import UIKit
import CoreData

class AddNewPersonViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var fatherNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    enum controlType {
        case Save
        case Update
    }
    var type : controlType = .Save
    
    var individualPerson = Person()
    var obId = NSManagedObjectID()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Add new person"
        var btn1 = UIBarButtonItem()
        if self.type == .Save {
            btn1 = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveBtnOnTap))
            btn1.tintColor = UIColor.white
        }
        else {
            btn1 = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(updateBtnOnTap))
            btn1.tintColor = UIColor.white
        }
        self.navigationItem.rightBarButtonItem = btn1
        let btn2 = UIBarButtonItem(image: UIImage(named: "BackArrow.pdf"), style: .plain, target: self, action: #selector(backBtnOnTap))
        self.navigationItem.leftBarButtonItem = btn2
        self.loadDetils()
    }
    
    func loadDetils() {
        if self.type == .Update {
            self.nameTextField.text = self.individualPerson.name
            self.ageTextField.text = String(self.individualPerson.age)
            self.fatherNameTextField.text = self.individualPerson.fatherName
            self.addressTextView.text = self.individualPerson.address
        }
    }
    
    @objc func saveBtnOnTap() {
        if (!((self.nameTextField.text?.isEmpty)!) && !((self.ageTextField.text?.isEmpty)!) && !((self.fatherNameTextField.text?.isEmpty)!) && !(self.addressTextView.text.isEmpty)) {
            let obj = Person.saveDetails(name: self.nameTextField.text!, age: Int16(self.ageTextField.text!)!, address: self.addressTextView.text, fatherName: self.fatherNameTextField.text!)
            if obj != nil {
                self.navigationController?.popViewController(animated: true)
            }
        }
        else {
            self.showAlert(msg: "Please enter all the fields", title: "Alert!", loadHomePage: false)
        }
    }
    
    @objc func updateBtnOnTap() {
        let isUpdate =  Person.updateContent(name: self.nameTextField.text!, age: Int16(self.ageTextField.text!)!, fatherName: self.fatherNameTextField.text!, address: self.addressTextView.text, updatedPersonObj: self.obId)
        if isUpdate == true {
            self.showAlert(msg: "Updated Successfully", title: "Success", loadHomePage: true)
        }
    }
    
    func showAlert(msg : String, title : String, loadHomePage : Bool)
    {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            action -> Void in
            if loadHomePage == true {
                self.navigationController?.popViewController(animated: true)
            }
        })
        self.present(alertController, animated: true)
        {}
    }
    
    @objc func backBtnOnTap() {
        self.navigationController?.popViewController(animated: true)
    }
}
