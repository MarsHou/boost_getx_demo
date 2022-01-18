package com.example.boost_getx

import android.app.Activity
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import com.idlefish.flutterboost.FlutterBoost

import com.idlefish.flutterboost.FlutterBoostRouteOptions




/**
 * Created by Mars on 2022/1/18 14:26.
 */
class YourTargetActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_target)

        findViewById<Button>(R.id.btnView).setOnClickListener {
            val options = FlutterBoostRouteOptions.Builder()
                .pageName("simplePage")
                .arguments(HashMap())
                .requestCode(1111)
                .build()
            FlutterBoost.instance().open(options)
        }
    }
}