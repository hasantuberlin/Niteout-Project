package com.example.kiran.niteout.Adapters

import android.content.Context
import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView
import androidx.core.content.ContextCompat.startActivity
import androidx.recyclerview.widget.RecyclerView
import com.example.kiran.niteout.CinemaList
import com.example.kiran.niteout.DataModels.MovieRepoMovy
import com.example.kiran.niteout.R
import com.example.kiran.niteout.Utilities.DataElement
import com.example.kiran.niteout.Utilities.printl
import com.irozon.mural.extension.source

class MovieAdapter(mContext: Context, val movieList: ArrayList<MovieRepoMovy>) : RecyclerView.Adapter<MovieAdapter.ViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val v = LayoutInflater.from(parent.context).inflate(R.layout.listofmovies_adapter, parent, false)
        return ViewHolder(v)
    }

    override fun getItemCount(): Int {
        return movieList.size
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {

        var movieRepoMovy = movieList.get(position)
        holder.movie.text = movieRepoMovy.title
        holder.votes.text = "Votes: " + movieRepoMovy.runtime.toString()
        holder.genre.text = "Genre: " + movieRepoMovy.genres
        holder.rating.text = "Ratings: " + movieRepoMovy.ratings.toString()
        holder.poster.source = movieRepoMovy.poster
        holder.movie_id = movieRepoMovy.movieId

        holder.itemView.setOnClickListener { it: View? ->
            DataElement.selected_movie_id = movieRepoMovy.movieId
            printl("Clicked and Id: ${DataElement.selected_movie_id}")
            prepareIntent(it)
        }
    }

    private fun prepareIntent(it: View?) {
        val intent = Intent(it?.context, CinemaList::class.java)
        startActivity(it!!.context, intent, null)
    }


    class ViewHolder(itemView : View) : RecyclerView.ViewHolder(itemView) {
        var movie = itemView.findViewById<TextView>(R.id.movie_name)
        var votes = itemView.findViewById<TextView>(R.id.votes)
        var genre = itemView.findViewById<TextView>(R.id.genre)
        var rating = itemView.findViewById<TextView>(R.id.rating)
        var poster = itemView.findViewById<ImageView>(R.id.posterImageView)

        var movie_id = ""

    }
}