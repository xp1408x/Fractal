//
//  AddOrUpdateViewController.swift
//  Fractal
//
//  Created by Pedro Cortez on 11/6/20.
//  Copyright © 2020 gamestorming. All rights reserved.
//

import UIKit

class AddOrUpdateViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    var clientManager = ClientManager()
    
    var client = Client()
    var isUpdate = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if isUpdate{
            self.setElements()
        }
//        self.script()
        // Do any additional setup after loading the view.
    }
    
    func setElements(){
        self.firstName.text = self.client.firstName
        self.lastName.text = self.client.lastName
        self.email.text = self.client.email
        self.phone.text = self.client.phone
    }
    
    func script(){
        for i in 101..<1000{
            self.client.firstName = "Nombre\(i)"
            self.client.lastName = "Apellido\(i)"
            self.client.email = "noname@gmail.com"
            self.client.phone = "12345\(i)"
            self.clientManager.addClient(client: self.client)
        }
        
        self.emptyTextField()
    }
    
    @IBAction func addClient(_ sender: UIButton){
        if isUpdate{
            self.update()
        }else{
            self.add()
        }
    }
    
    func update(){
        self.client.firstName = self.firstName.text ?? ""
        self.client.lastName = self.lastName.text ?? ""
        self.client.email = self.email.text ?? ""
        self.client.phone = self.phone.text ?? ""
        self.clientManager.updateClient(client: self.client)
        self.emptyTextField()
    }
    
    func add(){
        self.client.firstName = self.firstName.text ?? ""
        self.client.lastName = self.lastName.text ?? ""
        self.client.email = self.email.text ?? ""
        self.client.phone = self.phone.text ?? ""
        self.clientManager.addClient(client: self.client)
        self.emptyTextField()
    }
    
    func emptyTextField(){
        self.firstName.text = ""
        self.lastName.text = ""
        self.email.text = ""
        self.phone.text = ""
        let alertController = UIAlertController(title: "Fractal",
                                                message: "Succesful",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
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
