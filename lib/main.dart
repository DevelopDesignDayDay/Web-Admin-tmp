import 'package:ddd_admin_web/res/firebase_config.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart';

void main() {
  initializeApp(
    apiKey: FireBaseStrings.FIRESTORE_API_KEY,
    authDomain: FireBaseStrings.FIRESTORE_AUTH_DOMAIN,
    databaseURL: FireBaseStrings.FIRESTORE_DATABASE_URL,
    projectId: FireBaseStrings.FIRESTORE_PROJECT_ID,
    storageBucket: FireBaseStrings.FIRESTORE_STORAGE_BUCKET,
    messagingSenderId: FireBaseStrings.FIRESTORE_MESSAGING_SENDER_ID,
  );

  runApp(MaterialApp(
    title: 'DDD 3기 관리자',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: DDDMainPage(),
  ));
}

class DDDMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DDDMainPage();
}

class _DDDMainPage extends State<DDDMainPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  List<int> attendCount = List();
  @override
  void initState() {
    controller = new TabController(vsync: this, length: 5);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  getAttendanced(String uuid) async => await firestore()
          .collection("users")
          .doc(uuid)
          .collection("attendance")
          .get()
          .then((snapshot) {
        setState(() {
          attendCount.add(snapshot.docs.length);
          print(attendCount.length);
        });
      });

  Widget _buildList(DocumentSnapshot document, int index) {
    getAttendanced(document.data()["uuid"]);
    return Padding(
        padding: EdgeInsets.only(top: 24, bottom: 24, left: 16, right: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "이름 : ${document.data()["name"]} ",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text("Position : ${document.data()["position"]}",
                  style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
              Text((attendCount.isNotEmpty)
                  ? "출석 진행 : ${attendCount[index]}"
                  : "출석 진행 안함"),
              Divider(color: Colors.grey)
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("DDD ADMIN",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.person), text: "전체"),
            Tab(icon: Icon(Icons.mobile_screen_share), text: "iOS"),
            Tab(icon: Icon(Icons.mobile_screen_share), text: "AOS"),
            Tab(icon: Icon(Icons.computer), text: "Backend"),
            Tab(icon: Icon(Icons.computer), text: "Designer"),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: firestore().collection("users").onSnapshot,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (_, index) {
                return _buildList(snapshot.data?.docs[index], index);
              },
            );
          }
        },
      ),
    );
  }
}
