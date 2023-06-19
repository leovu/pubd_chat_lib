import 'package:flutter/material.dart';
import 'package:pubd_chat/connection/chat_connection.dart';
import 'package:pubd_chat/pubd_chat.dart';

void main() {
  runApp(const ApplicationApp());
}

class ApplicationApp extends StatelessWidget {
  const ApplicationApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> data = {
    "token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI3ZTc1NDU1YzAwZDg0MjliOWM3ZGYzMWYzYWE1NDM0MCIsInVzZXJUeXBlIjoiY29uc3VtZXIiLCJpYXQiOjE2ODcxNDg5NTR9.eNE6Ly27Xto6oqSwWSMG-oY80U8bng92f1nZDNiL-j4",
    "id": "7e75455c00d8429b9c7df31f3aa54340",
    "UserName": "isc.hungnv165",
    "FullName": "Bích Châu Trần",
    "Email": "vanhung3339 @gmail.com",
    "Phone": "0975271384",
    "Gender": "male",
    "Dob": 1993,
    "StatusView": 0,
    "MessageId": "d2f6b897e6e84786b787ae5c2a134b5a",
    "AccessToken":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50LWlkIjoiMyIsImFjY291bnQtbmFtZSI6ImlzYy5odW5nbnYxNjUiLCJyb2xlLWlkIjoiMSIsImppZCI6IjMyZjc4MDQyLWZhMWYtNDkxZi05ZjFiLWFkZmYyOGQyY2I3YSIsIm5iZiI6MTY4NzE1Njc2MywiZXhwIjoxNjg3MTYwMzYzLCJpYXQiOjE2ODcxNTY3NjMsImlzcyI6InBlcnNvbmFsX3Vua25vd25fYmF0dGxlX2RhdGUiLCJhdWQiOiJQVUJEQVBQIn0.-0NzABK7x724X_tviDASG4Sx1q2tpr4D5cwBZBv1sdw",
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                    PubdChat.open(context, data["id"], 'assets/icon-app.png',
                        const Locale('vi', 'VN'), {
                          "data":data
                        },
                        domain: 'http://14.225.192.203/',
                        mainDomain: 'https://pubd.site/',
                        isShowEmoji: true,
                        isShowSendImage: false,
                        sendActionBonus: sendActionBonus);
                  },
                  child: Container(
                      height: 40.0,
                      width: 80.0,
                      color: Colors.blue,
                      child: const Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )))),
            ),
          ],
        ),
      ),
    );
  }

  sendActionBonus(dynamic value) {
    print(value);
    PubdChat.showEmoji(true);
    PubdChat.showSendImage(true);
  }
}
