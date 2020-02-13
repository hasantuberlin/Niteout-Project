package com.example.kiran.niteout.DataModels

import org.json.JSONObject


class MovieViewModel(val data: ArrayList<MovieRepoMovy>,val date:String, val userLong: Double, val userLat: Double, val cuisinePreference: JSONObject) {

    override fun toString(): String {
       return """date: $date,
            userlong: $userLong,
            data: ${data.size}
            cuisine: ${cuisinePreference.toString()}
        """.trimMargin()
    }
}


//arrMovies : [MovieRepoMovy], date : String , userLong : Double , userLat: Double , cuisinePreference : [String : Int])