package com.example.kiran.niteout.Adapters

import android.content.Context
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.recyclerview.widget.RecyclerView
import com.example.kiran.niteout.DataModels.VotingData
import com.example.kiran.niteout.R
import com.example.kiran.niteout.Utilities.cuisines
import com.example.kiran.niteout.Utilities.genres
import com.example.kiran.niteout.Utilities.printl
import java.lang.Exception

class VotingAdapter(mContext: Context, val dataType: Int) : RecyclerView.Adapter<VotingAdapter.ViewHolder>() {
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val v = LayoutInflater.from(parent.context).inflate(R.layout.listvoting_adapter, parent, false)
        return ViewHolder(v)
    }

    override fun getItemCount(): Int {
        return if (dataType == 0) {
            genres.size
        } else cuisines.size
            }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
            var votingList = ArrayList<VotingData>()
            if (dataType == 0){
                votingList = genres
            }else{
                votingList = cuisines
            }

            var votingData = votingList.get(position)
            holder.identifierName.text = votingData.title
            holder.valueName.setText("${votingData.votes}")
            holder.id = votingData.id
            holder.type = votingData.type
            holder.valueName.addTextChangedListener(object : TextWatcher {
                override fun afterTextChanged(s: Editable?) {
                }

                override fun beforeTextChanged(
                    s: CharSequence?,
                    start: Int,
                    count: Int,
                    after: Int
                ) {
                    return
                }

                override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                    try{
                        votingData.votes = s.toString().toInt()
                        votingList[position] = votingData
                    } catch (e: Exception){
                        Toast.makeText(holder.itemView.context, "Please enter valid vote number", Toast.LENGTH_LONG).show()
                    }
                }
            })
    }

    class ViewHolder(itemView : View) : RecyclerView.ViewHolder(itemView) {
        var identifierName = itemView.findViewById<TextView>(R.id.voting_identifier)
        var valueName = itemView.findViewById<EditText>(R.id.editid)
        var id = -1
        var type = -1

    }
}