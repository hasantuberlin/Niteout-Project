//
//  NavigationViewController.swift
//  NiteOut
//
//  Created by Hamza Khan on 04/02/2020.
//  Copyright (c) 2020 Hamza Khan. All rights reserved.
//

import UIKit

class NavigationViewControlller: UIViewController
{
    var viewModel : NavigationViewModel!
    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            tblView.register(UINib(nibName: "NavigationTableViewCell", bundle: nil), forCellReuseIdentifier: "NavigationTableViewCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
}
extension NavigationViewControlller{
    func setupView(){
        self.tblView.estimatedRowHeight = 300
        self.tblView.rowHeight = UITableView.automaticDimension
        self.tblView.reloadData()
    }
}
extension NavigationViewControlller : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Cinema Navigation Guide"
        }
        return "Restaurant Navigation Guide"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.viewModel.getCinemaSteps().count
        }
        return self.viewModel.getRestaurantSteps().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NavigationTableViewCell", for: indexPath) as! NavigationTableViewCell
        let cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row, section: indexPath.section)
        cell.viewModel = cellViewModel
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}

