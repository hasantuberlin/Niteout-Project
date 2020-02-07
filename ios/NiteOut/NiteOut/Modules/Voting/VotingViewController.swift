//
//  VotingViewController.swift
//  NiteOut
//
//  Created by Hamza Khan on 17/01/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import UIKit
class VotingViewController: UIViewController {
    
    var viewModel: VotingViewModel!
    @IBOutlet weak var tblView : UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
            tblView.register(UINib(nibName: "VotingTableViewCell", bundle: nil), forCellReuseIdentifier: "VotingTableViewCell")
        }
    }
    @IBOutlet weak var btnNext : UIButton!
    var picker: UIPickerView?
    var toolBar = UIToolbar()
    var dummyTextField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPicker()
    }
}
extension VotingViewController {
    func setupView(){
        self.tblView.reloadData()
        self.btnNext.addTarget(self, action: #selector(self.didTapOnNext), for: .touchUpInside)
    }
    @objc func didTapOnNext(){
        self.viewModel.postData { (success, msg, data) in
            if success{
                let sb = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(identifier: "MovieListViewController") as! MovieListViewController
                guard let data = data else { return }
                vc.viewModel = MovieViewModel(data, date: self.viewModel.date, userLong: self.viewModel.userLong, userLat: self.viewModel.userLat, cuisinePreference: self.viewModel.getCuisinePreference())
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func setupPicker(){
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height:300))
        picker!.backgroundColor = .white
        picker!.showsSelectionIndicator = true
        picker!.delegate = self
        picker!.dataSource = self
        toolBar = UIToolbar(frame: CGRect(x:0,y:200-50,width: view.frame.width,height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: Selector("donePicker"))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        picker?.backgroundColor = .red
        self.dummyTextField.inputView = picker;
        self.dummyTextField.inputAccessoryView = toolBar
        self.view.addSubview(dummyTextField)
//        self.view.addSubview(picker!)
//        self.view.addSubview(toolBar)
//        self.view.bringSubviewToFront(picker!)
//        self.view.bringSubviewToFront(toolBar)
    }
}
extension VotingViewController{
  
}
extension VotingViewController : UITableViewDataSource , UITableViewDelegate, VotingButtonProtocol{
    func didTapOnVoting(row: Int, type: Int) {
        print(row)
        dummyTextField.tag = type
        dummyTextField.accessibilityValue = "\(row)"
        dummyTextField.becomeFirstResponder()
//        self.picker?.isHidden = false
//        self.toolBar.isHidden = false
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.getSections()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.getTitleForSection(section: section)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getRowsForSection(section: section)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VotingTableViewCell", for: indexPath) as! VotingTableViewCell
        let cellViewModel = self.viewModel.cellViewModelForRow(row: indexPath.row, section: indexPath.section)
        cell.votingCellViewModel = cellViewModel
        cell.delegate = self
        return cell
    }
}

extension VotingViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    @objc func donePicker(){
        self.dummyTextField.resignFirstResponder()
    }
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let votes = row
        let section = dummyTextField.tag
        let row = Int(dummyTextField.accessibilityValue ?? "0") ?? 0
        self.viewModel.setData(row: row, section: section, votes: votes)
        let indexPath = IndexPath(row: row, section: section)
        tblView.reloadRows(at: [indexPath], with: .automatic)
    }
}
