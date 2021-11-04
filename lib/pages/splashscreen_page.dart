// ignore_for_file: unrelated_type_equality_checks, prefer_const_constructors, unused_local_variable

import 'dart:async';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:admin_operasional/pages/home_page.dart';
import 'package:admin_operasional/pages/login_page.dart';
import 'package:admin_operasional/services/Api.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
// const storage = FlutterSecureStorage();

class SplashscreenPage extends StatefulWidget {
  const SplashscreenPage({Key? key}) : super(key: key);

  @override
  _SplashscreenPageState createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  late Api api;
  late SharedPreferences pref;
  late String jwt = '';
  @override
  void initState()  {
    super.initState();
    startSplashscreen();

  }


  startSplashscreen() async {
    pref = await SharedPreferences.getInstance();
    jwt =  (pref.getString('jwt') ?? '');
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {

      print('jwt: ' + jwt);
      // String? jwt = await storage.read(key: 'jwt');
      // print(jwt);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return jwt != '' ? HomePage() : LoginPage() ;
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade500,
      body: Container(
        decoration: const BoxDecoration(
          // ignore: unnecessary_const
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6594BB),
              Color(0xFF5A85A8),
              Color(0xFF506C95),
              Color(0xFF465682),
              Color(0xFF3C5170),
              Color(0xFF32395D),
              Color(0xFF28314A),
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Image.asset(
            "assets/images/logo.png",
            width: 80,
            height: 80,
          ),
        ),
      ),
    );
  }
}
