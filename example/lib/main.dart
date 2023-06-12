import 'package:flutter/material.dart';
import 'package:pubd_chat/pubd_chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String chatId = "";
  Map<String,dynamic> data = {
    "UserName": "moeomeo",
    "FullName": "nguyen van hung",
    "Email": "vanhung3339@gmail.com",
    "Phone": "0377377794",
    "Gender": "male ",
    "Dob": 12122023,
    "StatusView": 0,
    "Image": "123.jpg",
    "MessageId": "c7c5f3ec-c560-4dc0-82ee-16f2dd25d7a2",
    "UrlImageView": "https://pubd.site/public/images/123.jpg",
    "id":"",
    "token":""
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
                onTap: () async {
                  PubdChat.open(context,
                      chatId,
                      'assets/icon-app.png',
                    const Locale('vi', 'VN'), data,
                    domain: 'https://pubd.site/api/',
                    chatDomain: 'http://14.225.192.203',
                    sendActionBonus: sendActionBonus
                  );
                },
                child: Container(
                    height: 40.0,
                    width: 80.0,
                    color: Colors.blue,
                    child: const Center(child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)))),
          ),
        ],
      ),
    );
  }
  sendActionBonus(dynamic value) {
    print(value);
  }
}
