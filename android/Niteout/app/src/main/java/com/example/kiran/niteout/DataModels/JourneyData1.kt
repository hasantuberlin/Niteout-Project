package com.example.kiran.niteout.DataModels

import com.example.kiran.niteout.Utilities.journeyCinema
import com.example.kiran.niteout.Utilities.printl
import me.akatkov.kotlinyjson.JSON
import org.json.JSONArray
import org.json.JSONObject

class JourneyData1 {
    var travelTime: Int = 0
    var journeys : ArrayList<JourneyDataJourney>

    override fun toString(): String {
        return """
            travelTime : $travelTime,
            journeys: ${journeys.size}
        """.trimIndent()
    }

    constructor(travelTime: Int, journeys: ArrayList<JourneyDataJourney>){
        this.travelTime = travelTime
        this.journeys = journeys
    }

    constructor(jsonObject: JSON){

            this.travelTime = jsonObject.get("TravelTime").intValue(0)
        val x = jsonObject.get("Journey").toString()
            if (!x.isEmpty()){
                val y = JSONArray(x)
                printl("not empty in here!")
                this.journeys = toJourneyArray(y)

            }else{
                this.journeys = ArrayList<JourneyDataJourney>()
                return
            }

    }

    private fun toJourneyArray(jsonArray: JSONArray): ArrayList<JourneyDataJourney> {
        val journeyList = java.util.ArrayList<JourneyDataJourney>()

        for (i in 0 until jsonArray.length()){
            val journeyObject = JSON(jsonArray.getJSONObject(i).toString())
            val journeyDataJourney = JourneyDataJourney(journeyObject)
            journeyList.add(journeyDataJourney)
        }
        printl("called!")
        return journeyList
    }


}