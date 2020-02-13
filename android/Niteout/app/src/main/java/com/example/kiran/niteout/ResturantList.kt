package com.example.kiran.niteout

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ListView
import android.widget.TextView
import android.widget.Toast
import androidx.core.content.ContextCompat
import com.android.volley.AuthFailureError
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.example.kiran.niteout.DataModels.RestaurantDetailRestaurant
import com.example.kiran.niteout.DataModels.ShowTimeShowtime
import com.example.kiran.niteout.Utilities.*
import me.akatkov.kotlinyjson.JSON
import org.json.JSONArray
import org.json.JSONObject
import java.util.ArrayList

class ResturantList : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_resturant_list)

        getRestaurants()


        val list_view = findViewById<ListView>(R.id.resturantList);
        list_view.adapter = ResturantList.CustomAdapter(this);
    }


    // request restaurants
    private fun getRestaurants() {
        // 1. Create Root Object
        /*        let params = [
           "Date": date,
           "CinemaLocation": cinemaData,
            "UserLocation": userData,
            "CuisinePreferences": cuisineData
            ] as [String : Any]*/


        val rootObject = JSONObject()

        // 2. Add Date
        rootObject.put("Date", DataElement.date)

        // 3. Add CinemaLocation
        val cinemaData = JSONObject()
        cinemaData.put("lat", DataElement.cinemaLat)
        cinemaData.put("lon", DataElement.cinemaLong)
        rootObject.put("CinemaLocation", cinemaData)

        // 4. Add UserLocation
        val userData = JSONObject()
        userData.put("lat", DataElement.userLat)
        userData.put("lon", DataElement.userLong)
      //  userData.put("address", DataElement.userAddress)
        rootObject.put("UserLocation", userData)

        // 5. add CuisineData
        rootObject.put("CuisinePreferences", DataElement.cuisineData)


        var mQueue = Volley.newRequestQueue(this)
        val url = baseURL + "restaurants"
        printl("$url")
        printl(rootObject.toString())
        val restaurantRequest: JsonObjectRequest = object : JsonObjectRequest(
            Request.Method.POST,
            url, rootObject,
            object : Response.Listener<JSONObject> {
                override fun onResponse(response: JSONObject) {

                    val jsonArray = response.getJSONArray("Restaurants")
                    restaurants = getRestaurantsFromArray(jsonArray)

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

        mQueue.add(restaurantRequest)


    }

    private fun getRestaurantsFromArray(jsonArray: JSONArray): ArrayList<RestaurantDetailRestaurant> {
        val restaurantDetailRestaurantList = ArrayList<RestaurantDetailRestaurant>()

        for (i in 0 until jsonArray.length()){
            val restaurantObject = JSON(jsonArray.getJSONObject(i).toString())
            val restaurantDetailRestaurant = RestaurantDetailRestaurant(restaurantObject)
            restaurantDetailRestaurantList.add(restaurantDetailRestaurant)
        }

        return restaurantDetailRestaurantList
    }

    private fun fillTable() {
        val list_view = findViewById<ListView>(R.id.resturantList);
        list_view.adapter = ResturantList.CustomAdapter(this);
    }

    private class CustomAdapter(context: Context): BaseAdapter(){

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
            return restaurants.size;
        }
        //responsible for display all attribute
        override fun getView(position: Int, convertView: View?, viewGroup: ViewGroup?): View {
            val layoutInflatter = LayoutInflater.from(mContext);
            val rowMain = layoutInflatter.inflate(R.layout.listofresturant_adapter, viewGroup, false)

            val restName = rowMain.findViewById<TextView>(R.id.rest_name)
            val address = rowMain.findViewById<TextView>(R.id.address)
            val rating = rowMain.findViewById<TextView>(R.id.rating)
            val price_level = rowMain.findViewById<TextView>(R.id.price_level)
            var is_open = rowMain.findViewById<TextView>(R.id.is_open)

            val restaurant = restaurants.get(position)
            restName.text = restaurant.name
            address.text = "Address: " + restaurant.address
            rating.text = "Rating : " + restaurant.rating.toString()
            price_level.text = "Price Level: " + restaurant.priceLevel.toString()
            is_open.text = "Open: " + restaurant.openNow.toString()

            rowMain.setOnClickListener { it: View? ->
                DataElement.restaurantLat = restaurant.lat
                DataElement.restaurantLong = restaurant.lon
                DataElement.restaurantAddress = restaurant.address
                prepareIntent(it)
            }

            return rowMain
        }

        private fun prepareIntent(it: View?) {
            val intent = Intent(it!!.context, CinemaNavigation::class.java)
            ContextCompat.startActivity(it.context, intent, null)
        }
    }
}
