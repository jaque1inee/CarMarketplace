//
//  HomePresenter.swift
//  CarMarketplace
//
//  Created by Jaqueline Oliveira on 15/11/22.
//

import Foundation
import Alamofire
import CoreData

protocol HomePresenterDelegate: AnyObject {
    func didSuccessListCars(results: [ListCar])
    func didFailureListCars(error: String)
    
    func didSoldCar()
    func didFailureSellingCar(error: String)
}

class HomePresenter {
    
    weak var delegate: HomePresenterDelegate?
    var dataManager = DataManager()
    
    func getListCars() {
        AF.request("https://wswork.com.br/cars.json", method: .get).response {  response in
            switch response.result {
            case .success:
                do {
                    let results: [ListCar] = try JSONDecoder().decode([ListCar].self, from: response.data ?? Data())
                    self.delegate?.didSuccessListCars(results: results)
                    print("tudo certoo")
                } catch {
                    self.delegate?.didFailureListCars(error: "Algo deu errado! Try")
                }
            case .failure(_):
                self.delegate?.didFailureListCars(error: "Algo deu errado!")
                
            }
        }
    }
    
    // retorna lista de carros na tabela car sold e faz post de cada um
    @objc
    func postCarSelection() {
        
        let fetchRequest = dataManager.persistentContainer.viewContext
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CarSold")
        
        do {
            
            let result = try fetchRequest.fetch(fetch)
            
            for data in result as! [NSManagedObject] {
                
                if let car_name = data.value(forKey: "car_name") as? String,
                   let user_name = data.value(forKey: "user_name") as? String,
                   let user_email = data.value(forKey: "user_email") as? String {
                    
                    
                    let parameters: Parameters = [
                        "car_name": car_name,
                        "user_name": user_name,
                        "user_email": user_email,
                    ]
                    
                    let url = URL(string: "https://www.wswork.com.br/cars/leads/")!
                    AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                        .response { response in
                            switch response.result {
                            case .success(let response):
                                print(response)
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                }
            }
        } catch { }
    }
    // Vende e salva na tabela CarSold
    func buyCar(name: String, username: String, email: String) {
        let managedContext = dataManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CarSold", in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        
        user.setValue(email, forKey: "user_email")
        user.setValue(username, forKey: "user_name")
        user.setValue(name, forKey: "car_name")
        
        do {
            
            try managedContext.save()
            self.delegate?.didSoldCar()
            
        } catch let error as NSError {
            
            self.delegate?.didFailureSellingCar(error: "Erro ao criar usuário. \(error), \(error.userInfo)")
        }
    }
}
