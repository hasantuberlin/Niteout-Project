//
//  HomeViewController.swift
//  NiteOut
//
//  Created by Hamza Khan on 14/01/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import UIKit
import CoreLocation
//import TextFieldEffects
class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var btnNext : UIButton!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        setupLocationManager()
    }
    
    
    
}
extension HomeViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentLocation == nil {
            currentLocation = locations.last
//            locationManager?.stopMonitoringSignificantLocationChanges()
            let locationValue:CLLocationCoordinate2D = manager.location!.coordinate

            print("locations = \(locationValue)")

//            locationManager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")

    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // authorized location status when app is in use; update current location
            locationManager.startUpdatingLocation()
            // implement additional logic if needed...
        }
    }
   
}
extension HomeViewController{
    
    func setupLocationManager(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()

    }

    func setupView(){
        txtDatePicker.addInputViewDatePicker(target: self, selector: #selector(self.doneButtonPressed))
        btnNext.addTarget(self, action: #selector(self.didTapOnNext), for: .touchUpInside)
        
    }
    @objc func didTapOnNext(){
        print("Next")
        let isValidated = validate().0
        let msg = validate().1
        if isValidated{
            let date = self.txtDatePicker.text ?? ""
            let sb = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "VotingViewController") as! VotingViewController
            vc.viewModel = VotingViewModel(date, userLong: 13.40342, userLat: 52.51379)
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
        else{
            print(msg)
            if msg == "Please allow location"{
                locationManager.requestLocation()
            }
            else{
                self.txtDatePicker.becomeFirstResponder()
            }
        }
        
        
    }
    func validate()->(Bool , String){
        if self.txtDatePicker.text == ""{
            return (false , "Enter Date")
        }
        else if currentLocation == nil{
            return (false, "Please allow location")
        }
        else{
            return (true , "")
        }
        
    }
  
    @objc func doneButtonPressed() {
        if let  datePicker = self.txtDatePicker.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            let format = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.dateFormat = format
            dateFormatter.timeZone = TimeZone.current
            self.txtDatePicker.text = dateFormatter.string(from: datePicker.date)
        }
        self.txtDatePicker.resignFirstResponder()
    }
}
