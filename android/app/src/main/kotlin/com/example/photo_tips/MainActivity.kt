package com.example.photo_tips

import io.flutter.embedding.android.FlutterActivity
// import android.os.Bundle
// import android.os.Build
// import android.graphics.Color
// import android.view.WindowManager
// import android.view.View

class MainActivity: FlutterActivity() {
     //override fun onCreate(savedInstanceState: Bundle?) {
    //     super.onCreate(savedInstanceState)
    //     if (Build.VERSION.SDK_INT >= 19 && Build.VERSION.SDK_INT < 21) {
    //         setWindowFlag(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS or WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION, true)
    //     }
    //     if (Build.VERSION.SDK_INT >= 19) {
    //         // visibility = View.SYSTEM_UI_FLAG_LAYOUT_STABLE | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN;
    //         //visibility = visibility | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION;
    //         window.getDecorView().setSystemUiVisibility((View.SYSTEM_UI_FLAG_LAYOUT_STABLE or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN) or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION)
    //     }
    //     if (Build.VERSION.SDK_INT >= 21) {
    //         setWindowFlag(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS or WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION, false)
    //         window.setStatusBarColor(Color.TRANSPARENT)
    //         window.setNavigationBarColor(Color.TRANSPARENT)
    //     }
    //     // if (Build.VERSION.SDK_INT >= 19 && Build.VERSION.SDK_INT < 21) {
    //     //     setWindowFlag(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS, true)
    //     //     //setWindowFlag(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS, true)
    //     // }
    //     // if (Build.VERSION.SDK_INT >= 19) {
    //     //     window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_STABLE or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
    //     //    // setWindowFlag(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS, true)
    //     // }
    //     // if (Build.VERSION.SDK_INT >= 21) {
    //     //     setWindowFlag(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS, false)
    //     //     //setWindowFlag(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS, true)
    //     //     window.statusBarColor = Color.TRANSPARENT
    //     //     window.navigationBarColor = Color.TRANSPARENT
    //     // }

     //     window.decorView.apply {
     //          javaClass.declaredFields
     //             .firstOrNull { it.name == "mSemiTransparentBarColor" }
     //             ?.apply { isAccessible = true }
     //              ?.setInt(this, Color.TRANSPARENT)
     //      }
        //window.navigationBarColor = Color.TRANSPARENT
     //}

    // private fun setWindowFlag(bits: Int, on: Boolean) {
    //     val win = window
    //     val winParams = win.attributes
    //     if (on) {
    //         winParams.flags = winParams.flags or bits
    //     } else {
    //         winParams.flags = winParams.flags and bits.inv()
    //     }
    //     win.attributes = winParams
    // }
}
