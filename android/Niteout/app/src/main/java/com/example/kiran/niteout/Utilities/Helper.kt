package com.example.kiran.niteout.Utilities

import android.util.Log
import com.example.kiran.niteout.DataModels.*
import me.akatkov.kotlinyjson.JSON

fun printl(text: String){
    Log.d("xyz", text)
}

fun strToMonth(mMonth: Int) : String {
    var str = ""
    var mon = mMonth + 1
    if (mon<=9){ str = "0$mon" } else {
        str = "$mon"
    }
    return str
}


fun strToDay(mDay: Int) : String {
    var str = ""

    if (mDay<=9){ str = "0$mDay" } else {
        str = "$mDay"
    }
    return str
}

var genres = ArrayList<VotingData>()
var cuisines = ArrayList<VotingData>()

var cinemas = ArrayList<ShowTimeCinema>()
var showtimes = ArrayList<ShowTimeShowtime>()

var restaurants = ArrayList<RestaurantDetailRestaurant>()

var journeyData1 = JourneyData1(JSON())
var journeyData2 = JourneyData1(JSON())

var journeyCinema = ArrayList<JourneyDataJourney>()
var journeyRestaurant = ArrayList<JourneyDataJourney>()
