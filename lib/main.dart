import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neechat/BottomNavigation/auth_ser.dart';
import 'package:neechat/firebase_options.dart';
import 'package:neechat/login/signup.dart';
import 'package:neechat/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
  runApp(const MyApp());
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background notifications here
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, 
      getPages: Routes().getpages,
      home:  FutureBuilder(
        future: AuthMethods().getcurrentUser(),
        builder: (context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasData){
          return SignUp();
        }else{
          return SignUp();
        }
      }));
      
      //  Splash());
  }
}
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
   @override
     void initState() {
    super.initState();
    Timer(
        const Duration(seconds:5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const Auth())));
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor:Colors.amber,
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie.asset(MEDIMAGE.splash, fit: BoxFit.fill),
               const SizedBox(
                        height: 50,
                      ),
                      Text("MEDSTRING.medtez",style:TextStyle(fontSize: 28,fontWeight: FontWeight.w900,color: const Color.fromARGB(255, 2, 82, 179), shadows: <Shadow>[
                                Shadow(
                                  blurRadius: 5,
                                  color: Colors.blueGrey,
                                ),
                               
                              ],),),
          ],
        ),
      ),
    );
  }
}