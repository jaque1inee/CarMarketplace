//
//  CreaterUserViewController.swift
//  CarMarketplace
//
//  Created by Jaqueline Oliveira on 20/11/22.
//

import UIKit

class RegisterUserViewController: UIViewController {

    @IBOutlet weak var nameUserTextField: UITextField!
    @IBOutlet weak var emailUserTextField: UITextField!
    @IBOutlet weak var passwordUserTextField: UITextField!
    var presenter: RegisterUserPresenter = RegisterUserPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegate = self
    }
    
    @IBAction func createrUserViewController(_ sender: Any) {
        presenter.createUser(email: emailUserTextField.text ?? "",
                             name: nameUserTextField.text ?? "",
                             password: passwordUserTextField.text ?? "")
    }
    
    @IBAction func didBackPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RegisterUserViewController: RegisterUserPresenterDelegate {
    func didCreatedUser() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didFailureCreatingUser(error: String) {
        print(error)
    }
}
