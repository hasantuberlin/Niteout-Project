package com.example.kiran.niteout.DataModels

import android.os.Parcel
import android.os.Parcelable
import com.example.kiran.niteout.Utilities.printl
import me.akatkov.kotlinyjson.JSON
import org.json.JSONArray

class MovieRepoMovy() : Parcelable {
    var movieId: String = ""
    var poster: String = ""
    var ratings: Double = 0.0
    var runtime:Int = 0
    var title: String = ""
    var genres: String = ""

    constructor(parcel: Parcel) : this() {
        movieId = parcel.readString()!!
        poster = parcel.readString()!!
        ratings = parcel.readDouble()
        runtime = parcel.readInt()
        title = parcel.readString()!!
        genres = parcel.readString()!!
    }

    constructor(jsonObject: JSON) : this() {
        movieId = jsonObject.get("movie_id").stringValue("")
        poster = jsonObject.get("poster").stringValue("")
        ratings = jsonObject.get("ratings").doubleValue(0.0)
        runtime = jsonObject.get("runtime").intValue(0)
        title = jsonObject.get("title").stringValue("")
        genres = ""
        val mGenres = jsonObject.get("genres").toString()
        val mGenreArray = JSONArray(mGenres)
        for (i in 0 until mGenreArray.length()){
            val genreObject = JSON(mGenreArray.get(i).toString())
            genres += genreObject.get("name")
            genres += " "
        }
    }
    constructor(movieId: String, poster:String, ratings:Double, runtime:Int, title:String, genres: String) : this() {
        this.movieId = movieId
        this.poster = poster
        this.ratings = ratings
        this.runtime = runtime
        this.title = title
        this.genres = genres
    }

    override fun toString(): String {
        return """
            title:   $title,
            movieId: $movieId,
            poster: ${poster},
            ratings: $ratings,
            runtime: $runtime
            genres: $genres
        """.trimIndent()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(movieId)
        parcel.writeString(poster)
        parcel.writeDouble(ratings)
        parcel.writeInt(runtime)
        parcel.writeString(title)
        parcel.writeString(genres)

    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<MovieRepoMovy> {
        override fun createFromParcel(parcel: Parcel): MovieRepoMovy {
            return MovieRepoMovy(parcel)
        }

        override fun newArray(size: Int): Array<MovieRepoMovy?> {
            return arrayOfNulls(size)
        }
    }
}
