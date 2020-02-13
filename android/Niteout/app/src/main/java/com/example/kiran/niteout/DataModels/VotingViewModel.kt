package com.example.kiran.niteout.DataModels

import android.os.Parcel
import android.os.Parcelable

class VotingViewModel(val date: String?, val userLong: Double, val userLat: Double) : Parcelable {


    constructor(parcel: Parcel) : this(
        parcel.readString(),
        parcel.readDouble(),
        parcel.readDouble()
    ) {
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(date)
        parcel.writeDouble(userLong)
        parcel.writeDouble(userLat)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<VotingViewModel> {
        override fun createFromParcel(parcel: Parcel): VotingViewModel {
            return VotingViewModel(parcel)
        }

        override fun newArray(size: Int): Array<VotingViewModel?> {
            return arrayOfNulls(size)
        }
    }

}