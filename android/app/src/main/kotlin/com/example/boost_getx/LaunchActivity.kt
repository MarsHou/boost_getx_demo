package com.example.boost_getx

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.idlefish.flutterboost.FlutterBoost
import com.idlefish.flutterboost.FlutterBoostRouteOptions

/**
 * Created by Mars on 2022/1/18 16:16.
 */
class LaunchActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val options = FlutterBoostRouteOptions.Builder()
            .pageName("simplePage")
            .arguments(HashMap())
            .requestCode(1111)
            .build()
        FlutterBoost.instance().open(options)
        finish()
    }
}