import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neechat/Views/chat.dart';
import 'package:neechat/Views/chatRoom.dart';
import 'package:neechat/service/db.dart';
import 'package:neechat/service/shared_prefere.dart';
import 'package:neechat/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool search = false;
  String? myName, myProfilePic, myUserName, myEmail;
  Stream? chatRoomsStream;

  getthesharedpref() async {
    myName = await SharedPref().getdisName();
    myProfilePic = await SharedPref().getUserImg();
    myUserName = await SharedPref().getUserName();
    myEmail = await SharedPref().getUserMail();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    chatRoomsStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  getChatRoomIdbyUsername(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  var queryResultSet = [];
  var tempSearchStore = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 217, 231, 237),

          body: CustomScrollView(
            
            slivers:[
              
SliverAppBar(
  backgroundColor:COLORNICHAT.BLUES,
            centerTitle: true,
             automaticallyImplyLeading: false,
            title: const Text('NiChat',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900,color: Colors.black),),
                   bottom: AppBar(
                            centerTitle: true,
 automaticallyImplyLeading: false,
   backgroundColor: COLORNICHAT.BLUES,

              title: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(230, 222, 221, 221),
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
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500)),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
             
            ),),
              SliverList(
                 delegate: SliverChildListDelegate([
             Container(
                child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                   const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 2,
                ),
                Container(
                  child: Column(
                    children: [
                      search
                          ? ListView(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              primary: false,
                              shrinkWrap: true,
                              children: tempSearchStore.map((element) {
                                return searchName(element);
                              }).toList())
                          : ChatRoomList(),
                    ],
                  ),
                ),
              ]),
            )),
            ]))
          
          ])
          ),
    );
  }

  Widget searchName(data) {
    return GestureDetector(
      onTap: () async {
        search = false;

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
              color: const Color.fromARGB(0, 110, 97, 97), borderRadius: BorderRadius.circular(34)),
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
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ChatRoomList() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.black,
                        endIndent: 1,
                        indent: 1,
                      ),
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    print(ds.id);
                    return ChatRoomListTile(
                        chatRoomId: ds.id,
                        lastMessage: ds["lastMessage"],
                        myUsername: myUserName!,
                        time: ds["lastMessageSendTs"]);
                  })
              :SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset("lib/assets/loding.json", fit: BoxFit.fill));
        });
  }

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
}
