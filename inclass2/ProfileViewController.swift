//
//  ProfileViewController.swift
//  inclass2
//
//  Created by Ankit Kelkar on 10/25/18.
//  Copyright © 2018 Ankit Kelkar. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
 public var student:Profile?
    public var parentView:Any?
    @IBOutlet weak var nametext: UILabel!
    
    @IBOutlet weak var emailText: UILabel!
    
    @IBOutlet weak var departmentText: UILabel!
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var showBtn: UIButton!
   
    private var isPasswordVisible = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        isPasswordVisible = false
        nametext.text = student?.name
        emailText.text = student?.emailid
        passwordText.text = student?.password
        departmentText.text = student?.department
        updatePasswordVisibility()
        let parentVC = parentView as? ViewController
        parentVC?.student=student
    }
    @IBAction func toggleVisibility(_ sender: UIButton) {
        isPasswordVisible = !(isPasswordVisible)
        updatePasswordVisibility()
    }
    func updatePasswordVisibility(){
        if isPasswordVisible {
            passwordText.isSecureTextEntry = false
            showBtn.setTitle("Hide", for: UIControl.State.normal)
        }
        else{
            passwordText.isSecureTextEntry = true
            showBtn.setTitle("Show", for: UIControl.State.normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as? EditViewController
        editViewController?.condition = segue.identifier
        editViewController?.parentView = self
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
