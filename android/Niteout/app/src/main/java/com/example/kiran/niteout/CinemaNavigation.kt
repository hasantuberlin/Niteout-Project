package com.example.kiran.niteout

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ListView
import android.widget.TextView
import android.widget.Toast
import com.android.volley.*
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.example.kiran.niteout.DataModels.JourneyData1
import com.example.kiran.niteout.Utilities.*
import me.akatkov.kotlinyjson.JSON
import org.json.JSONObject

class CinemaNavigation : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_cinema_navigation)

        getJourney()

    }

    private fun getJourney() {

        /*
        * let parameters = [
          "Date": "2020-01-31T17:15:00+01:00",
          "CinemaLocation": [
            "lat": 52.5059,
            "lon": 13.3331,
            "address": "Hardenbergstraße 29A, 10623 Berlin"
          ],
          "RestaurantLocation": [
            "lat": 52.5062864,
            "lon": 13.3178534,
            "address": "Kantstraße 30, Berlin"
          ],
          "UserLocation": [
            "lat": 52.51379,
            "lon": 13.40342,
            "address": "Brüderstraße"
          ]
        ] as [String : Any]
        * */

        // 1. Create Root Object
        val rootObject = JSONObject()

        // 2. Add Date
        rootObject.put("Date", DataElement.date)

        // 3. Add CinemaLocation
        val cinemaData = JSONObject()
        cinemaData.put("lat", DataElement.cinemaLat)
        cinemaData.put("lon", DataElement.cinemaLong)
        cinemaData.put("address", DataElement.cinemaAddress)
        rootObject.put("CinemaLocation", cinemaData)

        // 4. Add Restaurant Location
        val restaurantData = JSONObject()
        restaurantData.put("lat", DataElement.restaurantLat)
        restaurantData.put("lon", DataElement.restaurantLong)
        restaurantData.put("address", DataElement.restaurantAddress)
        rootObject.put("RestaurantLocation", restaurantData)

        // 5. Add UserLocation
        val userData = JSONObject()
        userData.put("lat", DataElement.userLat)
        userData.put("lon", DataElement.userLong)
        userData.put("address", "10587, Berlin-Charlottenburg, Einsteinufer 17")
        rootObject.put("UserLocation", userData)

        var mQueue = Volley.newRequestQueue(this)
        val url = baseURL + "journeys"
        printl("$url")
        printl(rootObject.toString())
        val restaurantRequest: JsonObjectRequest = object : JsonObjectRequest(
            Request.Method.POST,
            url, rootObject,
            object : Response.Listener<JSONObject> {
                override fun onResponse(response: JSONObject) {

                    val toCinema = JSON(response.toString()).get("ToCinema").get("1")
                    journeyData1 = JourneyData1(toCinema)
                    journeyCinema = journeyData1.journeys

                    val toRestaurant = JSON(response.toString()).get("ToRestaurant").get("1")
                    journeyData2 = JourneyData1(toRestaurant)
                    journeyRestaurant = journeyData2.journeys
                    fillTable()



                }
            },
            Response.ErrorListener {
                //Failure Callback
                Toast.makeText(this, it.localizedMessage, Toast.LENGTH_LONG).show()
                printl(it.toString())
                it.message?.let { it1 -> printl(it1) }
            }){
            @Throws(AuthFailureError::class)
            override fun getHeaders(): Map<String, String> {
                val params = HashMap<String, String>()
                params.put("Content-Type", "application/json");
                params.put("cache-control", "no-cache")
                params.put("Postman-Token", "ce237a02-a01f-4f66-86d3-216a8f218cd5")
                return params
            }
        }

        restaurantRequest.retryPolicy = DefaultRetryPolicy(60000, DefaultRetryPolicy.DEFAULT_MAX_RETRIES, DefaultRetryPolicy.DEFAULT_BACKOFF_MULT)
        mQueue.add(restaurantRequest)
    }

    private fun fillTable(){
        // To cinema
        val list_view_cinema = findViewById<ListView>(R.id.cinema_journey);
        list_view_cinema.adapter = CinemaNavigation.CustomAdapterCinema(this);

        // to Restaurant
      val list_view_restaurant = findViewById<ListView>(R.id.restaurant_journey)
        list_view_restaurant.adapter = CinemaNavigation.CustomAdapterRestaurant(this)
    }

    private class CustomAdapterCinema(context: Context): BaseAdapter(){

        private val mContext: Context

        init {
            mContext = context;
        }

        override fun getItem(position: Int): Any {
            return "Test String";
        }

        override fun getItemId(position: Int): Long {
            return position.toLong();
        }

        override fun getCount(): Int {
            return journeyCinema.size;
        }
        //responsible for display all attribute
        override fun getView(position: Int, convertView: View?, viewGroup: ViewGroup?): View {
            val layoutInflatter = LayoutInflater.from(mContext);
            val rowMain = layoutInflatter.inflate(R.layout.listofcinemanavigation_adapter, viewGroup, false)

            val destination = rowMain.findViewById<TextView>(R.id.destination)
            val deptTime = rowMain.findViewById<TextView>(R.id.depart_time)
            val arrivalTime = rowMain.findViewById<TextView>(R.id.arrival_time)
            val mode = rowMain.findViewById<TextView>(R.id.mode)
            val stop = rowMain.findViewById<TextView>(R.id.stop)
            val step = rowMain.findViewById<TextView>(R.id.step)


            // check isCinema
               destination.text = "Destination: " + journeyCinema.get(position).destination
                deptTime.text = "Departure Time: " +journeyCinema.get(position).departureTime
                arrivalTime.text = "Arrival Time: " +journeyCinema.get(position).arrivalTime
                mode.text = "By: " +journeyCinema.get(position).mode
                stop.text = "Starting At: " +journeyCinema.get(position).stop
                step.text = "Step: " +journeyCinema.get(position).step.toString()

            return rowMain
        }
    }

    private class CustomAdapterRestaurant(context: Context): BaseAdapter(){

        private val mContext: Context

        init {
            mContext = context;
        }

        override fun getItem(position: Int): Any {
            return "Test String";
        }

        override fun getItemId(position: Int): Long {
            return position.toLong();
        }

        override fun getCount(): Int {
            return journeyRestaurant.size;
        }
        //responsible for display all attribute
        override fun getView(position: Int, convertView: View?, viewGroup: ViewGroup?): View {
            val layoutInflatter = LayoutInflater.from(mContext);
            val rowMain = layoutInflatter.inflate(R.layout.listofcinemanavigation_adapter, viewGroup, false)

            val destination = rowMain.findViewById<TextView>(R.id.destination)
            val deptTime = rowMain.findViewById<TextView>(R.id.depart_time)
            val arrivalTime = rowMain.findViewById<TextView>(R.id.arrival_time)
            val mode = rowMain.findViewById<TextView>(R.id.mode)
            val stop = rowMain.findViewById<TextView>(R.id.stop)
            val step = rowMain.findViewById<TextView>(R.id.step)


            destination.text = "Destination: " + journeyRestaurant.get(position).destination
            deptTime.text = "Departure Time: " +journeyRestaurant.get(position).departureTime
            arrivalTime.text = "Arrival Time: " +journeyRestaurant.get(position).arrivalTime
            mode.text = "By: " +journeyRestaurant.get(position).mode
            stop.text = "Starting At: " +journeyRestaurant.get(position).stop
            step.text = "Step: " +journeyRestaurant.get(position).step.toString()

            return rowMain
        }
    }
}
