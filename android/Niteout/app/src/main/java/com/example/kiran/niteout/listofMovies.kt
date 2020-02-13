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
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.kiran.niteout.Adapters.MovieAdapter
import com.example.kiran.niteout.DataModels.MovieRepoMovy
import com.example.kiran.niteout.DataModels.MovieViewModel
import com.example.kiran.niteout.Utilities.DataElement
import com.example.kiran.niteout.Utilities.cuisines
import com.example.kiran.niteout.Utilities.genres
import com.example.kiran.niteout.Utilities.printl
import kotlinx.android.synthetic.main.activity_listof_movies.*
import org.json.JSONObject
import org.w3c.dom.Text

class listofMovies : AppCompatActivity() {

    lateinit var movieViewModel: MovieViewModel
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_listof_movies)
        val cuisinePreferences:JSONObject = reduceCuisine()
        DataElement.cuisineData = cuisinePreferences
        val movieArray = intent.getParcelableArrayListExtra<MovieRepoMovy>("data")
        val date:String = intent.getStringExtra("date")
        val userLong = intent.getDoubleExtra("userLong", 0.0)
        val userLat:Double = intent.getDoubleExtra("userLat", 0.0)
        movieViewModel = MovieViewModel(movieArray, date, userLong, userLat, cuisinePreferences)
        DataElement.date = date
        DataElement.userLat = userLat
        DataElement.userLong = userLong
        DataElement.movieViewModel = movieViewModel

        fillTable()
    }

    private fun fillTable() {
        val movieAdapter = MovieAdapter(this, movieViewModel.data)
        movie_recycler_view.adapter = movieAdapter
        movie_recycler_view.layoutManager = LinearLayoutManager(this, RecyclerView.VERTICAL, false)
    }

    private fun reduceCuisine(): JSONObject {
        val cuisineDict = JSONObject()
        for (i in cuisines){
            cuisineDict.put(i.title, i.votes)
        }
        return cuisineDict
    }
}
