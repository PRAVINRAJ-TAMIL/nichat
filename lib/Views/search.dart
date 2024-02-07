import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:neechat/Views/chat.dart';
import 'package:neechat/service/db.dart';
import 'package:neechat/utils/colors.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var queryResultSet = [];
  var tempSearchStore = [];
  bool search = false;
  String? myName, myProfilePic, myUserName, myEmail;

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    setState(() {
      search = true;
    });
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().Search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['username'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  getChatRoomIdbyUsername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: COLORNICHAT.GRAY,
                borderRadius: new BorderRadius.circular(34),
              ),
              child: TextFormField(
                onChanged: (value) {
                  initiateSearch(value.toString());
                },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    hintStyle: TextStyle(
                        color: COLORNICHAT.TEXTCOLOR,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500)),
                style: const TextStyle(
                    color: COLORNICHAT.WHITE, fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
            ),
Divider(thickness: 2,),

 ListView(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              primary: false,
                              shrinkWrap: true,
                              children: tempSearchStore.map((element) {
                                return searchName(element);
                              }).toList())

          ],
        ),
      ),
    );
  }

    Widget searchName(data) {
    return GestureDetector(
      onTap: () async {
        search = true;

        var chatRoomId = getChatRoomIdbyUsername(myUserName!, data["username"]);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, data["username"]],
        };
        await DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                    name: data["Name"],
                    profileurl: data["Photo"],
                    username: data["username"])));
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: COLORNICHAT.GRAY, borderRadius: BorderRadius.circular(34)),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    data["Photo"],
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                data["username"],
                style: const TextStyle(
                    color: COLORNICHAT.TEXTCOLOR,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
