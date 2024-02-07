import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neechat/BottomNavigation/bottomNavigat.dart';
import 'package:neechat/Views/home.dart';
import 'package:neechat/login/login_Screen.dart';


class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                return LoginScreen();
              } else {
                return BottomNAvigation();
              }
            }
          }),
    ));
  }
}

class AuthMethods{
  final FirebaseAuth auth= FirebaseAuth.instance;

  getcurrentUser()async
  {
return await auth.currentUser;
  }
}