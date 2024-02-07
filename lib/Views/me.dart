import 'package:flutter/material.dart';

class Me extends StatefulWidget {
  const Me({super.key});

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://static.vecteezy.com/system/resources/previews/000/643/743/original/people-user-icon-vector.jpg"),
              radius: 90,
            ),
          ),
          Positioned(
            child: IconButton(onPressed: () {}, icon: Icon(Icons.abc)),bottom: -10,
          )
        ],
      ),
    ));
  }
}
