//
//  ViewController.swift
//  CoreDataCommon
//
//  Created by Appzoc on 23/01/18.
//  Copyright © 2018 appzoc. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var logIn: UIButton!
    
    @IBAction func signUpAction(_ sender: Any) {
        let name = Name.text!
        let pw = password.text!
        if name != "" && pw != ""
        {
            CoreDataFunctions.fetchCarDetails(entityName: "Register")
            var flag = 0
            print(CoreDataFunctions.dataCount)
            for i in 0..<CoreDataFunctions.dataCount/2
            {
             let sampleData = CoreDataFunctions.Details[i]
             let uname = sampleData.value(forKey: "username") as! String
                print(uname)
             if uname == name
                {
                    flag = 1
                    break
                }
            }
            
            if flag == 0
            {
                CoreDataFunctions.addAction(entityName: "Register",key: "username",value: name)
                CoreDataFunctions.addAction(entityName: "Register",key: "password",value: pw)
                print("hii")
                CoreDataFunctions.show()
            }
            else
            {
                print("username already exist")
            }
        }
        else
        {
            print("error")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreDataFunctions.fetchCarDetails(entityName: "Register")
        CoreDataFunctions.show()
        CoreDataFunctions.delete()
        logIn.layer.cornerRadius = 3.0
        signUp.layer.cornerRadius = 3.0
        logIn.layer.borderColor = UIColor.gray.cgColor
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

