package com.example.kiran.niteout.Utilities

import com.example.kiran.niteout.DataModels.MovieViewModel
import me.akatkov.kotlinyjson.JSON
import org.json.JSONObject

object DataElement {
    var date: String = ""
    var userLong: Double = 0.0
    var userLat: Double = 0.0

    // movie selection
    lateinit var movieViewModel:MovieViewModel
    var selected_movie_id = ""
    var cuisineData: JSONObject = JSONObject()

    // cinema selection
    var cinemaLong = 0.0
    var cinemaLat = 0.0
    var cinemaAddress = ""

    // restaurant selection
    var restaurantLong = 0.0
    var restaurantLat = 0.0
    var restaurantAddress = ""

}