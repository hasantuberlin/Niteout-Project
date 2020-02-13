package com.example.kiran.niteout.DataModels

import me.akatkov.kotlinyjson.JSON

class ShowTimeShowtime {
    var cinemaId : String = ""
    var cinemaMovieTitle : String = ""
    var is3d : Boolean = false
    var isImax : Boolean = false
    var language : String = ""
    var movieId : String = ""
    var startAt : String = ""
    var subtitleLanguage : String = ""

    constructor(cinemaId: String, cinemaMovieTitle: String, is3d:Boolean, isImax:Boolean, language:String, movieId:String, startAt: String, subtitleLanguage:String){
        this.cinemaId = cinemaId
        this.cinemaMovieTitle = cinemaMovieTitle
        this.is3d = is3d
        this.isImax = isImax
        this.language = language
        this.movieId = movieId
        this.startAt = startAt
        this.subtitleLanguage = subtitleLanguage
    }

    constructor(jsonObject:JSON){
        this.cinemaId = jsonObject.get("cinema_id").stringValue("")
        this.cinemaMovieTitle = jsonObject.get("cinema_movie_title").stringValue("")
        this.is3d = jsonObject.get("is_3d").booleanValue(false)
        this.isImax = jsonObject.get("is_imax").booleanValue(false)
        this.language = jsonObject.get("language").stringValue("")
        this.movieId = jsonObject.get("movie_id").stringValue("")
        this.startAt = jsonObject.get("start_at").stringValue("")
        this.subtitleLanguage = jsonObject.get("subtitle_language").stringValue("")
    }

    override fun toString(): String {
        return """
            cinemaMovieTitle: $cinemaMovieTitle,
            cinemaId: $cinemaId,
            movieId: $movieId,
            startAt: $startAt
        """.trimIndent()
    }

}


