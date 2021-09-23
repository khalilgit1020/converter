
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imgtext_converter/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({ Key? key }) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: HomePage(),
        title:const Text('image to text converter',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
          color: Colors.black,
        ),),
        image: Image.asset('assets/imagetext.png'),
        photoSize: 130,
        backgroundColor: Colors.white,
        loadingText:const Text('from khalil hemaide',style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400
        ),),
        loaderColor: Colors.grey,

      ),
    );
  }
}
