//
//  MovieListViewController.swift
//  NiteOut
//
//  Created by Hamza Khan on 23/01/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController{
    var viewModel : MovieViewModel!
    @IBOutlet weak var bgImageView: UIImageView!

    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            tblView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
}
extension MovieListViewController{
    func setupView(){
        bgImageView.addBlur()
        self.tblView.estimatedRowHeight = 300
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.reloadData()
    }
}
extension MovieListViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Results"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getResults().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row)
        cell.viewModel = cellViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.performSegue(withIdentifier: "next", sender: self)
        self.viewModel.getShowtimeResults(row: indexPath.row) { (success, serverMsg, data) in
            print(data)
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "MovieResultsViewController") as! MovieResultsViewController
            guard let data = data else { return }
            guard let cinemaData = data.cinemas else { return }
            guard let showtimeData = data.showtimes else { return }
            vc.viewModel = MovieResultsViewModel(showtimeData, cinemaData, date: self.viewModel.date
                , userLong: self.viewModel.userLong, userLat: self.viewModel.userLat, cuisinePreference: self.viewModel.cuisinePreference)//(showtimeData, cinemaData, date: self.viewModel.date)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
