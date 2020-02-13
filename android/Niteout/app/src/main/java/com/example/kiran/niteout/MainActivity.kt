package com.example.kiran.niteout

import android.Manifest
import android.annotation.SuppressLint
import android.app.DatePickerDialog
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Looper
import android.provider.Settings
import android.view.View
import android.widget.Toast
import androidx.core.app.ActivityCompat
import com.example.kiran.niteout.DataModels.VotingViewModel
import com.example.kiran.niteout.Utilities.*
import com.google.android.gms.location.*
import kotlinx.android.synthetic.main.activity_main.*
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : AppCompatActivity() {

    val PERMISSION_ID = 42
    var user_latitude: Double = 0.0
    var user_longitude: Double = 0.0
    lateinit var mFusedLocationClient: FusedLocationProviderClient

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        mFusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
        getLastLocation()

        //Calendar
        val c = Calendar.getInstance();
        val year = c.get(Calendar.YEAR);
        val month = c.get(Calendar.MONTH);
        val day = c.get(Calendar.DAY_OF_MONTH);

        enterdate.setOnClickListener {
            val dpd = DatePickerDialog(this, DatePickerDialog.OnDateSetListener{view, mYear, mMonth, mDay->
                val format = "'T'HH:mm:ssZ"
                val sdf = SimpleDateFormat(format)
                val mon = strToMonth(mMonth)
                val de = strToDay(mDay)
                val currentDate = "$mYear-$mon-$mDay"+sdf.format(Date())
                calendar.text = currentDate
                // yyyy-MM-dd

                // create current date

            }, year, month, day)
            dpd.show();
        }
    }

    private fun isLocationEnabled(): Boolean {
        var locationManager: LocationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
        return locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER) || locationManager.isProviderEnabled(
            LocationManager.NETWORK_PROVIDER
        )
    }

    private fun checkPermissions(): Boolean {
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED &&
            ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED){
            return true
        }
        return false
    }

    private fun requestPermissions() {
        ActivityCompat.requestPermissions(
            this,
            arrayOf(Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION),
            PERMISSION_ID
        )
    }


    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        if (requestCode == PERMISSION_ID) {
            if ((grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
                // Granted. Start getting the location information
            }
        }
    }

    @SuppressLint("MissingPermission")
    private fun getLastLocation() {
        if (checkPermissions()) {
            if (isLocationEnabled()) {

                mFusedLocationClient.lastLocation.addOnCompleteListener(this) { task ->
                    var location: Location? = task.result
                    if (location == null) {
                        requestNewLocationData()
                    } else {
                        user_latitude = location.latitude
                        user_longitude = location.longitude
                        printl("Lat: $user_latitude, Lon: $user_longitude")
                    }
                }
            } else {
                Toast.makeText(this, "Turn on location", Toast.LENGTH_LONG).show()
                val intent = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
                startActivity(intent)
            }
        } else {
            requestPermissions()
        }
    }

    @SuppressLint("MissingPermission")
    private fun requestNewLocationData() {
        var mLocationRequest = LocationRequest()
        mLocationRequest.priority = LocationRequest.PRIORITY_HIGH_ACCURACY
        mLocationRequest.interval = 0
        mLocationRequest.fastestInterval = 0
        mLocationRequest.numUpdates = 1

        mFusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
        mFusedLocationClient!!.requestLocationUpdates(
            mLocationRequest, mLocationCallback,
            Looper.myLooper()
        )
    }

    private val mLocationCallback = object : LocationCallback() {
        override fun onLocationResult(locationResult: LocationResult) {
            var mLastLocation: Location = locationResult.lastLocation
            // new location
            user_latitude = mLastLocation.latitude
            user_longitude = mLastLocation.longitude


        }
    }

    fun nextBtnClicked(view: View){
        // check location set
        val locationValid = (user_latitude != 0.0 && user_longitude != 0.0)
        val dateValid = (!calendar.text.toString().isEmpty())

        if (locationValid && dateValid){
            // clear stuff
            // Intent to next Activity add values
            val intent = Intent(this, voting::class.java)
            val model = VotingViewModel(calendar.text.toString(), user_longitude, user_latitude)
            intent.putExtra("viewmodel", model)
            calendar.text = ""
            startActivity(intent)

        } else if (locationValid && !dateValid){
            Toast.makeText(this, "Please choose a valid date!", Toast.LENGTH_SHORT).show()
        } else if (!locationValid && dateValid){
            Toast.makeText(this, "The app can't access your location", Toast.LENGTH_SHORT).show()
        } else{
            Toast.makeText(this, "Please choose a valid date and provide a valid location", Toast.LENGTH_SHORT).show()

        }

    }
}
