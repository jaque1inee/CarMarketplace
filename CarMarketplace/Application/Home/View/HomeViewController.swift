//
//  HomeViewController.swift
//  CarMarketplace
//
//  Created by Jaqueline Oliveira on 14/11/22.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var carListTableView: UITableView!
    var cars: [ListCar] = []
    var presenter: HomePresenter = HomePresenter()
    var dataManager = DataManager()
    var user: UserModel?
    
    var leadSyncTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carListTableView.dataSource = self
        carListTableView.delegate = self
        presenter.delegate = self
        presenter.getListCars()
        leadSyncTimer = Timer.scheduledTimer(timeInterval: 30,
                                             target: self,
                                             selector: #selector(postCarSelection),
                                             userInfo: [],
                                             repeats: true)
    }
    
    @objc
    func postCarSelection() {
        
        self.presenter.postCarSelection()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as! CarTableViewCell
        let car = self.cars[indexPath.row]
        cell.setup(result: car)
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: HomePresenterDelegate {
    
    func didSoldCar() { }
    
    func didFailureSellingCar(error: String) {
        print(error)
    }
    
    func didSuccessListCars(results: [ListCar]) {
        self.cars = results
        carListTableView.reloadData()
        print("tudo ok")
    }
    
    func didFailureListCars(error: String) {
        print(error)
    }
}

extension HomeViewController: CarTableViewCellDelegate {
    
    func didAddPressed(modelo: String) {
        
        //self.presenter.postCarSelection(email: self.email ?? "")
        self.presenter.buyCar(name: modelo, username: user?.name ?? "", email: user?.email ?? "")
    }
}
