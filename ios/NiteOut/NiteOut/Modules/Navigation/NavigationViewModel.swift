//
//  NavigationViewModel.swift
//  NiteOut
//
//  Created by Hamza Khan on 04/02/2020.
//  Copyright (c) 2020 Hamza Khan. All rights reserved.
//

import UIKit

class NavigationViewModel
{
    let toCinema : JourneyDataToCinema!
    let toRestaurant : JourneyDataToCinema!
    
    init(_ cinema : JourneyDataToCinema, restaurant: JourneyDataToCinema ){
        self.toCinema = cinema
        self.toRestaurant = restaurant
    }
    func getCinemaSteps()->[JourneyDataJourney]{
        return (toCinema.one?.journey!) ?? []
    }
    
    func getRestaurantSteps()->[JourneyDataJourney]{
        return toRestaurant.one?.journey ?? []
    }
    func cellViewModelForRow(row: Int, section: Int)-> NavigationCellViewModel{
        var result = [JourneyDataJourney]()
        if section == 0{
            result = getCinemaSteps()
        }
        else{
            result = getRestaurantSteps()
            
        }
        let data = result[row]
        let arrivalTime  = data.arrivalTime ?? ""
        let departureTime = data.departureTime ?? ""
        let destination = data.destination ?? ""
        let direction = data.direction ?? ""
        let mode = data.mode ?? ""
        let step = data.step ?? 0
        let stop = data.stop ?? ""
        
        
        return NavigationCellViewModel(arrivalTime: arrivalTime, departureTime: departureTime, destination: destination, direction: direction, mode: mode, step: step, stop: stop)
    }
}

struct NavigationCellViewModel {
    let arrivalTime : String
    let departureTime : String
    let destination : String
    let direction : String
    let mode : String
    let step : Int
    let stop : String
    
    func getStop()->String{
        return "Stop: " + stop
    }
    func getDepartureTime()->String{
        return "Departure Time: " + departureTime
    }
    func getDestination()->String{
        return "Destination: " + destination
    }
    func getDirection()->String{
        return "Direction: " + direction
    }
    func getMode()->String{
        return "Mode: " + mode
    }
    func getStep()->String{
        return "Step: " + "\(step)"
    }
    func getArrivalTime()->String{
        return "Arrival Time: " + arrivalTime
    }
    
    
    
}
