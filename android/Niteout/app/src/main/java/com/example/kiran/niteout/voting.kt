package com.example.kiran.niteout

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.android.volley.AuthFailureError
import com.android.volley.DefaultRetryPolicy
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.Volley
import com.example.kiran.niteout.Adapters.VotingAdapter
import com.example.kiran.niteout.DataModels.MovieRepoMovy
import com.example.kiran.niteout.DataModels.MovieViewModel
import com.example.kiran.niteout.DataModels.VotingData
import com.example.kiran.niteout.DataModels.VotingViewModel
import com.example.kiran.niteout.Utilities.baseURL
import com.example.kiran.niteout.Utilities.cuisines
import com.example.kiran.niteout.Utilities.genres
import com.example.kiran.niteout.Utilities.printl
import kotlinx.android.synthetic.main.activity_voting.*
import kotlinx.android.synthetic.main.listofmovies_adapter.*
import me.akatkov.kotlinyjson.JSON
import org.json.JSONArray
import org.json.JSONObject

class voting : AppCompatActivity() {

    private lateinit var genreAdapter: VotingAdapter
    private lateinit var cuisineAdapter: VotingAdapter
    private lateinit var viewModel: VotingViewModel


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_voting)

        viewModel = intent.getParcelableExtra("viewmodel")
        printl("${viewModel.date}, ${viewModel.userLong}, ${viewModel.userLat}")


        addGenres()
        addCuisines()

        fillTableGenre()
        fillTableCuisine()
    }

    private fun addCuisines() {
        cuisines.add(VotingData("Asian", 0, 10, 1))
        cuisines.add(VotingData("German", 1, 5, 1))
        cuisines.add(VotingData("Turkish", 2, 7, 1))
        cuisines.add(VotingData("Indian", 3, 8, 1))
        cuisines.add(VotingData("Mexican", 4, 1, 1))
    }

    private fun addGenres() {
        genres.add(VotingData("Action", 0, 10, 0))
        genres.add(VotingData("Comedy", 1, 5, 0))
        genres.add(VotingData("Romantic", 2, 7, 0))
        genres.add(VotingData("Fiction", 3, 8, 0))
        genres.add(VotingData("Horror", 4, 1, 0))
    }


    fun fillTableGenre(){
        genreAdapter = VotingAdapter(this, 0)
        movie_voting.adapter = genreAdapter
        movie_voting.layoutManager = LinearLayoutManager(this, RecyclerView.VERTICAL, false)


    }

    fun fillTableCuisine(){
        cuisineAdapter = VotingAdapter(this, 1)
        cuisine_voting.adapter = cuisineAdapter
        cuisine_voting.layoutManager = LinearLayoutManager(this, RecyclerView.VERTICAL, false)

    }

    // This functions builds up a JSON Object and posts it to the API
    fun findMovies(){

        // 1. Create Root Object
        val rootObject = JSONObject()

        // 2. Add Date
        rootObject.put("Date", viewModel.date)

        // 3. Add GenrePref
        val genreDict = reduceGenrePrefs()
        rootObject.put("GenrePreferences", genreDict)

        // 4. Add lat and lon
        rootObject.put("UserLat", viewModel.userLat)
        rootObject.put("UserLon", viewModel.userLong)


        var mQueue = Volley.newRequestQueue(this)
        val url = baseURL + "movies"
        printl("$url")
        printl(rootObject.toString())
        val moviesRequest: JsonObjectRequest = object : JsonObjectRequest(
            Request.Method.POST,
            url, rootObject,
            object : Response.Listener<JSONObject> {
                override fun onResponse(response: JSONObject) {

                    val movies = response.get("Movies") as JSONArray
                    // implement response logic please
                    val movieArray: ArrayList<MovieRepoMovy> = getMovieArrayList(movies)
                    toMovieListView(movieArray)


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
        moviesRequest.retryPolicy = DefaultRetryPolicy(60000, DefaultRetryPolicy.DEFAULT_MAX_RETRIES, DefaultRetryPolicy.DEFAULT_BACKOFF_MULT)
        mQueue.add(moviesRequest)

    }

    private fun toMovieListView(movieArray: ArrayList<MovieRepoMovy>) {
        val intent = Intent(this, listofMovies::class.java)
        intent.putExtra("data", movieArray)
        intent.putExtra("date", viewModel.date)
        intent.putExtra("userLong", viewModel.userLong)
        intent.putExtra("userLat", viewModel.userLat)
        startActivity(intent)
    }

    private fun getMovieArrayList(json: JSONArray): ArrayList<MovieRepoMovy> {
      val movieRepoMovyList = ArrayList<MovieRepoMovy>()

      for (i in 0 until json.length()){
          val movieObject = JSON(json.getJSONObject(i).toString())
          val movieRepoMovy = MovieRepoMovy(movieObject)
          movieRepoMovyList.add(movieRepoMovy)
      }

        return movieRepoMovyList
    }

    private fun reduceGenrePrefs(): JSONObject {
        val genreDict = JSONObject()
        for (i in genres){
            genreDict.put(i.title, i.votes)
        }
        return genreDict
    }


    fun onSendClicked(view: View){
        findMovies()
    }


}
