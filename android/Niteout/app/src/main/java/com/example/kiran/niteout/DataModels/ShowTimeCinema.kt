package com.example.kiran.niteout.DataModels

import me.akatkov.kotlinyjson.JSON

class ShowTimeCinema {
    var address : String = ""
    var id : String = ""
    var lat : Double = 0.0
    var lon : Double = 0.0
    var name : String = ""

    constructor(address: String, id:String, lat:Double, lon: Double, name:String){
        this.address = address
        this.id = id
        this.lat = lat
        this.lon = lon
        this.name = name
    }
    constructor(jsonObject: JSON){
        this.address = jsonObject.get("address").stringValue("")
        this.id = jsonObject.get("id").stringValue("")
        this.lat = jsonObject.get("lat").doubleValue(0.0)
        this.lon = jsonObject.get("lon").doubleValue(0.0)
        this.name = jsonObject.get("name").stringValue("")
    }

    override fun toString(): String {
        return """
            name: $name,
            id: $id,
            address: $address
        """.trimIndent()
    }
}