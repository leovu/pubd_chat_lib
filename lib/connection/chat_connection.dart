import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubd_chat/connection/http_connection.dart';
import 'package:pubd_chat/connection/socket.dart';
import 'package:pubd_chat/model/contact.dart';
import 'package:pubd_chat/model/room.dart';
import 'package:pubd_chat/model/user.dart';
import 'dart:io';
import 'package:pubd_chat/model/message.dart' as c;
import 'package:image_picker/image_picker.dart';

class ChatStream<T> {
  final StreamController<T> stream = StreamController<T>();
  Sink<T> get _input => stream.sink;
  Stream<T> get output => stream.stream;
  T? _currentValue;
  T? get current => _currentValue;
  void update(T value) {
    _currentValue = value;
    _input.add(value);
  }
  void close() {
    stream.close();
  }
}

class ChatConnection {
  static late Locale locale;
  static ChatStream<bool> chatStreamEmoji = ChatStream();
  static ChatStream<bool> chatStreamSendImage = ChatStream();
  static StreamSocket streamSocket = StreamSocket();
  static HTTPConnection connection = HTTPConnection();
  static late String appIcon;
  static String? roomId;
  static User? user;
  static late BuildContext buildContext;
  static Function(dynamic)? sendActionBonus;
  static bool isLoadMore = false;
  static Future<bool>init(String chatId,Map<String, dynamic>? userData) async {
    HttpOverrides.global = MyHttpOverrides();
    if(userData != null) {
      user = User.fromJson(userData);
      streamSocket.connectAndListen(streamSocket,user!);
      return true;
    }
    else {
      return false;
    }
  }
  static Future<c.ChatMessage?>joinRoom(String id ,{bool refresh = false}) async {
    ResponseData responseData = await connection.get('room/$id?limit=15&page=0');
    if(responseData.isSuccess) {
      if(!refresh) {
        streamSocket.joinRoom(id);
      }
      return c.ChatMessage.fromJson(responseData.data);
    }
    return null;
  }
  static Future<Rooms?>initiate(List<String> userIds) async {
    Map<String,dynamic> json = {
      "userIds": userIds,
      "type": 'consumer-to-consumer'
    };
    ResponseData responseData = await connection.post('room/initiate', json);
    if(responseData.isSuccess) {
      return Rooms.fromJson(responseData.data['chatRoom']);
    }
    return null;
  }
  static Future<List<c.Messages>?>loadMoreMessageRoom(String id ,int index) async {
    ResponseData responseData = await connection.get('room/$id?limit=15&page=$index');
    if(responseData.isSuccess) {
      return c.ChatMessage.fromJson(responseData.data).message;
    }
    return null;
  }
  static Future<String?>upload(File file) async {
    ResponseData responseData = await connection.upload('update-image', file);
    if(responseData.isSuccess) {
      return responseData.data['Data']['Result']['UrlImageView'];
    }
    return null;
  }
  static File convertToFile(XFile xFile) => File(xFile.path);
  static Future<String?>sendChat(String id, String type, String messageText) async {
    Map<String,dynamic> json = {
      "type": type,
      "messageText": messageText
    };
    if(ChatConnection.sendActionBonus != null) {
      ChatConnection.sendActionBonus!(json);
    }
    ResponseData responseData = await connection.post('room/$id/message', json);
    if(responseData.isSuccess) {
      streamSocket.sendMessage(messageText, id);
      return responseData.data['post']['_id'];
    }
    return null;
  }
  static void listenChat(Function callback) {
    streamSocket.listenChat(callback);
  }
  static void unsubscribe() {
    streamSocket.unsubscribe(ChatConnection.roomId!);
  }
  static bool checkConnected() {
    if(streamSocket.socket == null) {
      return false;
    }
    return streamSocket.checkConnected();
  }
  static reconnect() {
    streamSocket.socket!.connect();
  }
  static dispose({bool isDispose = false}) {
    if(!isDispose) {
      streamSocket.socket!.disconnect();
    }
    else {
      streamSocket.socket!.disconnect();
      streamSocket.dispose();
    }
  }
  static closeChatStream() {
    chatStreamEmoji.close();
    chatStreamSendImage.close();
    chatStreamEmoji = ChatStream();
    chatStreamSendImage = ChatStream();
  }
}