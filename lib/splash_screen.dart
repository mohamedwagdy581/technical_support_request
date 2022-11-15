import 'dart:async';

import 'package:flutter/material.dart';

import 'modules/login/login_screen.dart';
import 'shared/components/components.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(
        const Duration(milliseconds: 3000),
            ()=> navigateAndFinish(context, LoginScreen())
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 60,
              child: Image(
                image: AssetImage(
                  'assets/images/baruziklogo.png',
                ),
                fit: BoxFit.cover,
                height: 200.0,
                width: 200.0,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),

            Text(
              'Baruzik',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
