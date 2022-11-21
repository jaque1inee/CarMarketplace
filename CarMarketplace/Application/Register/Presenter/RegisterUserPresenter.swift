//
//  CreaterUserPresenter.swift
//  CarMarketplace
//
//  Created by Jaqueline Oliveira on 20/11/22.
//

import Foundation
import CoreData

protocol RegisterUserPresenterDelegate: AnyObject {
    func didCreatedUser()
    func didFailureCreatingUser(error: String)
}

class RegisterUserPresenter {
    
    weak var delegate: RegisterUserPresenterDelegate?
    var dataManager = DataManager()
    
    func createUser(email: String, name: String, password: String) {
        let managedContext = dataManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        
        user.setValue(email, forKey: "email")
        user.setValue(name, forKey: "name")
        user.setValue(password, forKey: "password")
        
        do {
            
            try managedContext.save()
            self.delegate?.didCreatedUser()
            
        } catch let error as NSError {
            
            self.delegate?.didFailureCreatingUser(error: "Erro ao criar usuário. \(error), \(error.userInfo)")
        }
    }
}
