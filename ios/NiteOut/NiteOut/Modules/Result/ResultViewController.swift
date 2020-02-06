//
//  ResultViewController.swift
//  NiteOut
//
//  Created by Hamza Khan on 17/01/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var viewModel : ResultViewModel!
    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            tblView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultTableViewCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
}
extension ResultViewController{
    func setupView(){
        self.tblView.estimatedRowHeight = 300
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.reloadData()
    }
}
extension ResultViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Results"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getRestaurants().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
        let cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row)
        cell.viewModel = cellViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.getJourney(row: indexPath.row) { (success, serverMsg, data) in
            print(data)
            
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "NavigationViewControlller") as! NavigationViewControlller
            guard let data = data else { return }
            guard let cinema = data.toCinema else { return }
            guard let restaurant = data.toRestaurant else { return }
            
            vc.viewModel = NavigationViewModel(cinema, restaurant: restaurant)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
