import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:neechat/routes.dart';
import 'package:neechat/service/db.dart';
import 'package:neechat/service/shared_prefere.dart';
import 'package:random_string/random_string.dart';

import 'login_Screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passToggle = true;
  String mail = "", password = "", name = "", conpass = "";

  final TextEditingController _mail = TextEditingController();
  final TextEditingController _password = TextEditingController();
  // final TextEditingController _conpassword = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final form = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  createUserWithEmailAndPassword() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _mail.text,
        password: _password.text,
      );
      String Id = randomAlphaNumeric(10);
      String user = _mail.text.replaceAll("@gmail.com", "");
      String updateusername = user.replaceFirst(user[0], user[0].toUpperCase());
      String firstletter = user.substring(0, 1).toUpperCase();


      Map<String, dynamic> userInfoMap = {
        "Name": _name.text,
        "E-mail": _mail.text,
        "username": updateusername.toUpperCase(),
        "SearchKey": firstletter,
        "Photo":
            "https://static.vecteezy.com/system/resources/previews/000/643/743/original/people-user-icon-vector.jpg",
        "Id": Id,
      };
      await DatabaseMethods().addUserDetails(userInfoMap, Id);
      await SharedPreferenceHelper().saveUserId(Id);
      await SharedPreferenceHelper().saveUserDisplayName(_name.text);
      await SharedPreferenceHelper().saveUserMail(_mail.text);
      await SharedPreferenceHelper().saveUserImg(
                      "https://static.vecteezy.com/system/resources/previews/000/643/743/original/people-user-icon-vector.jpg",
);
      await SharedPreferenceHelper()
          .saveUserName(_mail.text.replaceAll("@gmail.com", "").toUpperCase());

      navigator?.pushNamed(LoginScreen as String);
      print("User Register: ${credential.user!.email}");
      print("======================================================================");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("Error:$e");
      print(e);
    }
  }

  bool isLogin = false;

  void togglePage() {
    isLogin = !isLogin;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
  
        body: SingleChildScrollView(
          child: Container(
            // height: double.maxFinite,
            // width: double.maxFinite,
            decoration: BoxDecoration(
              gradient: 
              LinearGradient(
              colors: [
          Colors.blue.shade200,
          Colors.blue.shade50,
          Colors.blue.shade50,
          Colors.blue.shade200
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                     height:MediaQuery.of(context).size.height/3.8,
                     width: MediaQuery.of(context).size.width/1,
                        alignment: Alignment.center,
                        child:
                             Lottie.asset("lib/assets/signin.json", fit: BoxFit.fill)),
                    // const SizedBox(height: 30),


Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
SizedBox(height: 30),

                    Container(
                        decoration: BoxDecoration(
                        color: Color.fromARGB(230, 222, 221, 221),
                        borderRadius: new BorderRadius.circular(34), 
                      ),
                      child: TextFormField(
                        controller: _name,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Enter name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                                                    border: InputBorder.none,
                            hintText: "User Name",

                            prefixIcon: const Icon(Icons.person_2_rounded)),
                      ),
                    ),
                    const SizedBox(height: 30),
                  
                        Container(
                        decoration: BoxDecoration(
                        color: Color.fromARGB(230, 222, 221, 221),
                        borderRadius: new BorderRadius.circular(34), 
                      ),
                      child: TextFormField(
                        controller: _mail,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Enter Mail";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            // border: const OutlineInputBorder(),
                            border: InputBorder.none,
                            hintText: 'Enter Mail',
                            prefixIcon: const Icon(Icons.mail_outline)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    //  TextFormField(
                    //   controller: password,
                    //    validator: (text){
                    //       if(text==null|| text.isEmpty){
                    //         return "Enter Passowrd";
                    //       }
                    //       return null;
                    //     },
                    //     decoration: InputDecoration(
                    //         border: const OutlineInputBorder(),
                    //         label: Text(MEDSTRING.enter_ph),
                    //         prefixIcon: const Icon(Icons.phone_iphone)),
                    //   ),
                    // const SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                        color: Color.fromARGB(230, 222, 221, 221),
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
                            // border: const OutlineInputBorder(),
                            border: InputBorder.none,
                            hintText: 'Enter Password',
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 128, 171, 244),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () {
                            if (form.currentState!.validate()) {
                              print("valide");
                              createUserWithEmailAndPassword();
                              Get.toNamed(Routes.loginscreen);
                            }
                          },
                          child: Text("Sign Up")),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already Have Account?"),
                   
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text("Sign In")),

                      
                           ],
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height/6.8)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
