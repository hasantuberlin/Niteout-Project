//
//  MovieResultsViewController.swift
//  NiteOut
//
//  Created by Hamza Khan on 04/02/2020.
//  Copyright (c) 2020 Hamza Khan. All rights reserved.
//

import UIKit

class MovieResultsViewController: UIViewController
{
    var viewModel : MovieResultsViewModel!
    @IBOutlet weak var bgImageView: UIImageView!

    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            tblView.register(UINib(nibName: "MovieResultTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieResultTableViewCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
}
extension MovieResultsViewController{
    func setupView(){
        bgImageView.addBlur()

        self.tblView.estimatedRowHeight = 300
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.reloadData()
    }
}
extension MovieResultsViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cinema List"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getShowTimeCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieResultTableViewCell", for: indexPath) as! MovieResultTableViewCell
        let cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row)
        cell.viewModel = cellViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.getRestaurantsResults(row: indexPath.row) { (success, msg, data) in
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "ResultViewController") as! ResultViewController
            guard let data = data else { return }
            guard let restaurants = data.restaurants else { return }
            vc.viewModel = ResultViewModel(restaurants, cinemaData: self.viewModel.getCinemaData(row: indexPath.row), userLocation: self.viewModel.getUserLocationData(),date: self.viewModel.date)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

