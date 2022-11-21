//
//  LoginUserPresenter.swift
//  CarMarketplace
//
//  Created by Jaqueline Oliveira on 20/11/22.
//

import Foundation
import CoreData

protocol LoginUserPresenterDelegate: AnyObject {
    func didSuccessLoginUser(user: UserModel)
    func didFailureLoginUser(error: String)
}

class LoginUserPresenter {
    
    weak var delegate: LoginUserPresenterDelegate?
    var dataManager = DataManager()
    
    func getUser(email: String, password: String) {
        
        let fetchRequest = dataManager.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicate = NSPredicate(format: "email = %@", argumentArray: [email])
        
        fetch.predicate = predicate
        
        do {
            
            let result = try fetchRequest.fetch(fetch)
            for data in result as! [NSManagedObject] {
                if email == data.value(forKey: "email") as! String && password == data.value(forKey: "password") as! String {
                    
                    self.delegate?.didSuccessLoginUser(user: UserModel(name: data.value(forKey: "name") as? String, email: email))
                    
                } else {
                    
                    self.delegate?.didFailureLoginUser(error: "Email ou password inválidos")
                }
            }
        } catch {
            self.delegate?.didFailureLoginUser(error: "Failed")
        }
    }
}
