//
//  EditViewController.swift
//  inclass2
//
//  Created by Ankit Kelkar on 10/25/18.
//  Copyright © 2018 Ankit Kelkar. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    public var condition:String?
    public var parentView:Any?
    public var departmentDictionary:[String:Int] = [
        "CS":0,
        "SIS":1,
        "BIO":2
    ]
     @IBOutlet weak var editLabel: UILabel!
    
    @IBOutlet weak var editText: UITextField!
    @IBOutlet weak var departmentSegmentController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(condition)
        print(parentView)
        // Do any additional setup after loading the view.
        let parentVC = parentView as? ProfileViewController
        
        if let segue = condition{
            switch segue {
            case "nameEditSegue":
                editLabel.text = "Name"
                editText.isHidden = false
                editText.text = parentVC?.student?.name
                departmentSegmentController.isHidden = true
                
            case "passwordEditSegue":
                editLabel.text = "Password"
                editText.isHidden = false
                editText.isSecureTextEntry = true
                editText.text = parentVC?.student?.password
                departmentSegmentController.isHidden = true
            case "departmentEditSegue":
                editLabel.text = "Department"
                editText.isHidden = true
                departmentSegmentController.isHidden = false
                departmentSegmentController.selectedSegmentIndex = departmentDictionary[(parentVC?.student?.department)!]!
                
            case "emailEditSegue":
                editLabel.text = "Email"
                editText.isHidden = false
                departmentSegmentController.isHidden = true
                editText.text = parentVC?.student?.emailid
            default:
                print("default case executed")
            }
        }
    }
   
    @IBAction func update(_ sender: UIButton) {
        if editText.text != "" || !departmentSegmentController.isHidden {
            let parentVC = parentView as? ProfileViewController
            let student = parentVC?.student
            
            if let segue = condition{
                switch segue {
                case "nameEditSegue":
                    student?.name = editText.text!
                case "passwordEditSegue":
                    student?.password = editText.text!
                case "departmentEditSegue":
                    student?.department = departmentSegmentController.titleForSegment(at: departmentSegmentController.selectedSegmentIndex)!
                case "emailEditSegue":
                    if !isValidEmail(testStr: editText.text!){
                        showMessage(msg: "invalid email address")
                        return
                    }
                    student?.emailid = editText.text!
                default:
                    print("default case executed")
                }
            }
            parentVC?.student = student
            //  self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
        else{
            let alert = UIAlertController(title: "Blank Fields", message: "Please enter the values", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler:nil))
            self.present(alert, animated: true, completion: nil)
        }
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
