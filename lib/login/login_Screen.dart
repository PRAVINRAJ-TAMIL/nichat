// ignore_for_file: file_names

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:neechat/BottomNavigation/bottomNavigat.dart';
import 'package:neechat/Views/home.dart';
import 'package:neechat/routes.dart';
import 'package:neechat/service/db.dart';
import 'package:neechat/service/shared_prefere.dart';
import 'package:neechat/utils/string.dart';

import '../utils/colors.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passToggle = true;
  bool isLoading = false;
  String email = "", password = "", name = "", pic = "", username = "", id = "";
  final TextEditingController mail = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController text = TextEditingController();
  final form = GlobalKey<FormState>();

  signInWithEmailAndPassword() async {
    try {
      //  setState(() {
      //   isLoading = true;
      // });
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail.text,
           password: _password.text);
      QuerySnapshot querySnapshot =
          await DatabaseMethods().getUserbyemail(email);

      name = "${querySnapshot.docs[0]["Name"]}";
      username = "${querySnapshot.docs[0]["username"]}";
      pic = "${querySnapshot.docs[0]["Photo"]}";
      id = querySnapshot.docs[0].id;
      await SharedPref().saveUserDisplayName(name);
      await SharedPref().saveUserName(username);
      await SharedPref().saveUserId(id);
      await SharedPref().saveUserImg(pic);
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => Home()));
      // print("User Login: ${credential.user!.email}");
      // print("User Login: ${credential.user!.}");
      Get.toNamed(Routes.bottomnavigation);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const BottomNAvigation()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
         
             decoration: const BoxDecoration(
              gradient: 
              LinearGradient(
              colors: [
       COLORNICHAT.BLUE,
                  COLORNICHAT.BLUES,
                  COLORNICHAT.BLUES,
                  COLORNICHAT.BLUE
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Form(
                key: form,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(alignment: Alignment.center, child:  SizedBox(
                        height: 250,
                        child: Lottie.asset("lib/assets/signup.json", fit: BoxFit.fill))),
                      const SizedBox(height: 30),
                      const Text(STRINGNICHAI.SIGNIN,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                      const SizedBox(height: 30),
                
                      Container(
                          decoration: BoxDecoration(
                          color: COLORNICHAT.GRAY,
                          borderRadius: new BorderRadius.circular(34), 
                        ),
                        child: TextFormField(
                          controller: mail,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Enter Mail";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                                border: InputBorder.none,
                              hintText: "Enter user name / Mail i'd",
                              prefixIcon: Icon(Icons.person_2_rounded)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                          decoration: BoxDecoration(
                          color: COLORNICHAT.GRAY,
                          borderRadius: new BorderRadius.circular(34), 
                        ),
                        child: TextFormField(
                          controller: _password,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Enter Passowrd";
                            }
                            return null;
                          },
                          obscureText: passToggle ? true : false,
                          decoration: InputDecoration(
                                border: InputBorder.none,
                              hintText:  "Enter Password",
                              prefixIcon: const Icon(Icons.lock_clock_rounded),
                              suffixIcon: InkWell(
                                onTap: () {
                                  if (passToggle == true) {
                                    passToggle = false;
                                  } else {
                                    passToggle = true;
                                  }
                                  setState(() {});
                                },
                                child: passToggle
                                    ? const Icon(CupertinoIcons.eye_slash_fill)
                                    : const Icon(CupertinoIcons.eye_fill),
                              )),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/3,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: COLORNICHAT.BTCOLOR,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              if (form.currentState!.validate()) {
                                setState(() {
                                  email = mail.text;
                                  password = _password.text;
                                });
                                print("===========================");
                                print("valide");
                                signInWithEmailAndPassword();
                              }
                            },
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : const Text(STRINGNICHAI.SIGNIN)),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.center ,
                        children: [
                          const Text(STRINGNICHAI.CREATE_ACC),
                       
                      TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.signup);
                          },
                          child: const Text(STRINGNICHAI.SIGNUP)), ],
                      ),
                SizedBox(height:MediaQuery.of(context).size.height/6.8)
                
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
