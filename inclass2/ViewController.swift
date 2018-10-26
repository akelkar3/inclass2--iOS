//
//  ViewController.swift
//  inclass2
//
//  Created by Ankit Kelkar on 10/25/18.
//  Copyright © 2018 Ankit Kelkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var department: UISegmentedControl!
    public var student:Profile?
    @IBOutlet weak var password: UITextField!
    public var departmentDictionary:[String:Int] = [
        "CS":0,
        "SIS":1,
        "BIO":2
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
          if student != nil {
            name.text = student?.name
            email.text = student?.emailid
            password.text = student?.password
            department.selectedSegmentIndex = departmentDictionary[(student?.department)!]!
            
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var status = false
        if let name = name.text,
            let email = email.text,
            let password = password.text{
            if (name != "") && (email != "") && (password != ""){
                status = true
            }
            else{
                showAlertMessage()
            }
        }
        
        return status
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare for segue called")
        if segue.identifier == "profileViewSegue" {
            if let name = name.text,
                let email = email.text,
                let password = password.text{
                
                if (name != "") && (email != "") && (password != ""){
                    if !isValidEmail(testStr: email){
                        showMessage(msg: "invalid email address")
                        return
                    }
                    let student = Profile(name: name, password: password, email: email, department: department.titleForSegment(at: department.selectedSegmentIndex)!)
                    let profileViewController = segue.destination as! ProfileViewController
                    profileViewController.student = student
                    profileViewController.parentView = self
                    print(student.emailid)
                }
                else{
                    showAlertMessage()
                }
                
            }
            else{
                showAlertMessage()
            }
            
        }
    }
    
    func showAlertMessage(){
        
        let alert = UIAlertController(title: "Blank Fields", message: "Please enter all the fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    func showMessage(msg:String){
        
        let alert = UIAlertController(title: "Blank Fields", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }


}

