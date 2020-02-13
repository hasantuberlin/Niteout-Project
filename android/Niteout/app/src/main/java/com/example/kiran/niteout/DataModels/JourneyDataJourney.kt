package com.example.kiran.niteout.DataModels

import com.example.kiran.niteout.Utilities.printl
import me.akatkov.kotlinyjson.JSON

class JourneyDataJourney {
    var arrivalTime : String = ""
    var departureTime : String =""
    var destination : String = ""
    var direction : String = ""
    var mode : String = ""
    var step: Int = 0
    var stop : String = ""

    constructor(arrivalTime: String,  departureTime : String, destination : String = "", direction : String, mode : String, step : Int, stop: String){
        this.arrivalTime = arrivalTime
        this.departureTime = departureTime
        this.destination = destination
        this.direction = direction
        this.mode = mode
        this.step = step
        this.stop = stop
    }
    constructor(jsonObject : JSON){
        this.arrivalTime = jsonObject.get("ArrivalTime").stringValue("")
        this.departureTime = jsonObject.get("DepartureTime").stringValue("")
        this.destination = jsonObject.get("Destination").stringValue("")
        this.direction = jsonObject.get("Direction").stringValue("")
        this.mode = jsonObject.get("Mode").stringValue("")
        this.step = jsonObject.get("Step").intValue(0)
        this.stop = jsonObject.get("Stop").stringValue("")
    }

    override fun toString(): String {
        return """
            direction: $direction,
            arrivalTime: $arrivalTime,
            mode: $mode,
            step: $step
        """.trimIndent()
    }


}