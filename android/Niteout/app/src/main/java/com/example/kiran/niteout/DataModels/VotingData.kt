package com.example.kiran.niteout.DataModels

class VotingData(val title: String, val id: Int, var votes:Int, val type:Int){

    override fun toString(): String {
        return """
            title: $title,
            id: $id,
            votes, $votes
            type, $type
        """.trimIndent()
    }
}