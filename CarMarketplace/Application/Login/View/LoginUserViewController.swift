//
//  LoginUserViewController.swift
//  CarMarketplace
//
//  Created by Jaqueline Oliveira on 20/11/22.
//

import UIKit

class LoginUserViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var presenter: LoginUserPresenter = LoginUserPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegate = self
    }
    
    @IBAction func loginUser(_ sender: Any) {
        presenter.getUser(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @IBAction func createrUser(_ sender: Any) {
        
        performSegue(withIdentifier: "createrUser", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goHome" {
            
            guard let user = sender as? UserModel else { return }
            guard let destinationVC = segue.destination as? HomeViewController else { return }
            destinationVC.user = user
        }
    }
}

extension LoginUserViewController: LoginUserPresenterDelegate {
    func didSuccessLoginUser(user: UserModel) {
        performSegue(withIdentifier: "goHome", sender: user)
    }
    
    func didFailureLoginUser(error: String) {
        print(error)
    }
}
