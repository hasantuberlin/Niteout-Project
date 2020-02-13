package com.example.kiran.niteout.DataModels

import me.akatkov.kotlinyjson.JSON

class RestaurantDetailRestaurant {
    var address : String = ""
    var id : String = ""
    var lat : Double = 0.0
    var lon : Double = 0.0
    var name : String = ""
    var openNow : Boolean = false
    var priceLevel : Int = 0
    var rating : Double = 0.0

    constructor(address:String, id:String, lat:Double, lon:Double, name:String, openNow:Boolean, priceLevel:Int, rating:Double){
        this.address = address
        this.id = id
        this.lat = lat
        this.lon = lon
        this.name = name
        this.openNow = openNow
        this.priceLevel = priceLevel
        this.rating = rating
    }

    constructor(jsonObject: JSON){
        this.address = jsonObject.get("address").stringValue("")
        this.id = jsonObject.get("id").stringValue("")
        this.lat = jsonObject.get("lat").doubleValue(0.0)
        this.lon = jsonObject.get("lon").doubleValue(0.0)
        this.name = jsonObject.get("name").stringValue("")
        this.openNow = jsonObject.get("open_now").booleanValue(false)
        this.priceLevel = jsonObject.get("price_level").intValue(0)
        this.rating = jsonObject.get("rating").doubleValue(0.0)
    }

    override fun toString(): String {
        return """
            name: $name
            address : $address,
            price_level : $priceLevel,
            rating: $rating
        """.trimIndent()
    }
}