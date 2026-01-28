import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ksehayak/Screens/login.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();     //new
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  //new
  runApp(MaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}