//
//  ViewController.swift
//  CoreData-OneToOne
//
//  Created by Devi on 02/04/18.
//  Copyright © 2018 Devi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var personsDisplayTblView: UITableView!
    
    var personDetails: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personsDisplayTblView.register(UINib(nibName: "PersonsDisplayTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonsDisplayTableViewCell")
        self.personsDisplayTblView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getPersonDetails()
        self.personsDisplayTblView.reloadData()
        self.title = "Person Details"
        let btn1 = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBtnOnTap))
        btn1.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = btn1
    }
    
    func getPersonDetails()  {
        personDetails = Person.fetchDetails() as! [Person]
    }
    
    @objc func addBtnOnTap() {
        let addPersonVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPersonViewController") as? AddNewPersonViewController
        addPersonVC?.type = .Save
        self.navigationController?.pushViewController(addPersonVC!, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonsDisplayTableViewCell", for: indexPath) as! PersonsDisplayTableViewCell
        cell.delegate = self
        let btn1 = MGSwipeButton(title: "", icon: UIImage(named:"Editicon.pdf"), backgroundColor: .clear)
        let btn2 = MGSwipeButton(title: "", icon: UIImage(named:"deleteimage.pdf"), backgroundColor: .clear)
        cell.rightButtons = [btn2!, btn1!]
        cell.rightSwipeSettings.transition = MGSwipeTransition.rotate3D
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.nameLbl.text = self.personDetails[indexPath.row].name
        return cell
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        let selectedIndexPath = self.personsDisplayTblView.indexPath(for: cell)!
        let selectedPerson = self.personDetails[selectedIndexPath.row]
        if index == 0 {
            self.showActionSheetWithTitle(title: "Are you sure?", message: nil, actionTitle: ["Delete", "Cancel"], actionStyle: [.destructive, .default], sourceView: self.view) { (tappedButton) in
                if tappedButton == "Delete" {
                    let flag = Person.deleteOperation(individualPerson: selectedPerson)
                    if flag == true {
                        self.personDetails.remove(at: selectedIndexPath.row)
                        self.personsDisplayTblView.deleteRows(at: [selectedIndexPath], with: .fade)
                    }
                }
            }
            return true
        }
        else {
            let addPersonVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPersonViewController") as? AddNewPersonViewController
            addPersonVC?.individualPerson = selectedPerson
            addPersonVC?.obId = selectedPerson.objectID
            addPersonVC?.type = .Update
            self.navigationController?.pushViewController(addPersonVC!, animated: true)
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPerson = self.personDetails[indexPath.row]
        let licenseVC = self.storyboard?.instantiateViewController(withIdentifier: "CorrespondingLicenseViewController") as? CorrespondingLicenseViewController
        licenseVC?.individualPerson = selectedPerson
        self.navigationController?.pushViewController(licenseVC!, animated: true)
    }
}

