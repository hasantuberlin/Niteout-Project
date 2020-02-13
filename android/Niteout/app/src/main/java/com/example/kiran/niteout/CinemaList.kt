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
import androidx.core.content.ContextCompat.startActivity
import com.android.volley.AuthFailureError
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.example.kiran.niteout.DataModels.MovieRepoMovy
import com.example.kiran.niteout.DataModels.ShowTimeCinema
import com.example.kiran.niteout.DataModels.ShowTimeShowtime
import com.example.kiran.niteout.Utilities.*
import kotlinx.android.synthetic.main.activity_cinema_list.*
import me.akatkov.kotlinyjson.JSON
import org.json.JSONArray
import org.json.JSONObject
import org.w3c.dom.Text
import java.util.ArrayList

class CinemaList : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_cinema_list)

        getMovieShowtimes()



    }

    private fun getMovieShowtimes() {

        // 1. Create Root Object
        val rootObject = JSONObject()

        // 2. Add Date
        rootObject.put("Date", DataElement.date)

        // 3. Add MovieId
        rootObject.put("MovieId", DataElement.selected_movie_id)

        // 4. Add lat and lon
        rootObject.put("UserLat", DataElement.userLat)
        rootObject.put("UserLon", DataElement.userLong)


        var mQueue = Volley.newRequestQueue(this)
        val url = baseURL + "showtimes"
        printl("$url")
        printl(rootObject.toString())
        val showtimeRequest: JsonObjectRequest = object : JsonObjectRequest(
            Request.Method.POST,
            url, rootObject,
            object : Response.Listener<JSONObject> {
                override fun onResponse(response: JSONObject) {

                    val cinemaArray = response.getJSONArray("Cinemas")
                    val showtimeArray = response.getJSONArray("Showtimes")
                     cinemas = getCinemasFromArray(cinemaArray)
                     showtimes = getShowtimesFromArray(showtimeArray)

                    fillTable()

                    for (i in 0 until cinemas.size){
                        printl(cinemas.get(i).toString())
                    }
                    for (i in 0 until showtimes.size){
                        printl(showtimes.get(i).toString())
                    }

                }
            },
            Response.ErrorListener {
                //Failure Callback
                Toast.makeText(this, it.localizedMessage, Toast.LENGTH_LONG).show()
                printl(it.toString())
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

        mQueue.add(showtimeRequest)

    }

    private fun getCinemasFromArray(cinemaArray: JSONArray): ArrayList<ShowTimeCinema> {
        val showTimeCinemaList = ArrayList<ShowTimeCinema>()

        for (i in 0 until cinemaArray.length()){
            val cinemaObject = JSON(cinemaArray.getJSONObject(i).toString())
            val showTimeCinema = ShowTimeCinema(cinemaObject)
            showTimeCinemaList.add(showTimeCinema)
        }

        return showTimeCinemaList
    }

    private fun getShowtimesFromArray(showtimeArray: JSONArray): ArrayList<ShowTimeShowtime> {
        val showTimeShowTimeList = ArrayList<ShowTimeShowtime>()

        for (i in 0 until showtimeArray.length()){
            val showTimeObject = JSON(showtimeArray.getJSONObject(i).toString())
            val showTimeShowtime = ShowTimeShowtime(showTimeObject)
            showTimeShowTimeList.add(showTimeShowtime)
        }

        return showTimeShowTimeList
    }

    private fun fillTable() {
        val adapter = CinemaList.CustomAdapter(this)
        cinema_list_view.adapter = adapter
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
            return showtimes.size;
        }
        //responsible for display all attribute
        override fun getView(position: Int, convertView: View?, viewGroup: ViewGroup?): View {
            val layoutInflatter = LayoutInflater.from(mContext);
            val rowMain = layoutInflatter.inflate(R.layout.listofcinema_adapter, viewGroup, false)

            val movieName = rowMain.findViewById<TextView>(R.id.movie_name)
            val movieTime = rowMain.findViewById<TextView>(R.id.movie_time)
            val movieLanguage = rowMain.findViewById<TextView>(R.id.movie_language)
            val D3 = rowMain.findViewById<TextView>(R.id.d3)
            val cinema_name = rowMain.findViewById<TextView>(R.id.cinema_name)
            val address = rowMain.findViewById<TextView>(R.id.address)


            // Set the stuff up.
            val row = showtimes.get(position)
            movieName.text = row.cinemaMovieTitle
            movieTime.text = "Starts at: " + row.startAt
            movieLanguage.text = "Language: " + row.language
            D3.text = "3D: " + row.is3d.toString()
            val cinema = getCinema(row.cinemaId)
            cinema_name.text = "Cinema: " + cinema.name
            address.text = "Adress: " + cinema.address


            // Later lets see which data i need.
            rowMain.setOnClickListener {
                DataElement.cinemaLat = cinema.lat
                DataElement.cinemaLong = cinema.lon
                DataElement.cinemaAddress = cinema.address
                prepareIntent(it)
            }

            return rowMain
        }

        private fun prepareIntent(it: View) {
            val intent = Intent(it.context, ResturantList::class.java)
            startActivity(it.context, intent, null)
        }

        private fun getCinema(cinemaId: String) : ShowTimeCinema {
            for (i in 0 until cinemas.size){
                val cinemaObject = cinemas.get(i)
                if (cinemaObject.id == cinemaId){
                    return cinemaObject
                }
            }
            return ShowTimeCinema(JSON())
        }
    }
}
