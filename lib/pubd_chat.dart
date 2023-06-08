import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pubd_chat/connection/chat_connection.dart';
import 'package:pubd_chat/connection/http_connection.dart';
import 'package:pubd_chat/connection/socket.dart';
import 'package:pubd_chat/model/message.dart' as c;
import 'package:pubd_chat/model/room.dart';
import 'package:pubd_chat/screen/chat_screen.dart';
import 'pubd_chat_platform_interface.dart';

class PubdChat {
  static BuildContext? context;
  static HTTPConnection connection = HTTPConnection();
  static StreamSocket streamSocket = StreamSocket();
  Future<String?> getPlatformVersion() {
    return PubdChatPlatform.instance.getPlatformVersion();
  }
  static Future<bool>connectSocket(BuildContext context,
      String chatId,
      String appIcon,
      Locale locale,
      Map<String,dynamic>? userData,
      { String? domain,
        String? chatDomain}) async {
    ChatConnection.buildContext = context;
    ChatConnection.appIcon = appIcon;
    bool result = await ChatConnection.init(chatId, userData);
    return result;
  }
  static disconnectSocket() {
    ChatConnection.dispose(isDispose: true);
  }
  static Future<c.ChatMessage?>joinRoom(String id ,{bool refresh = false}) async {
    ResponseData responseData = await connection.get('api/chat/room/$id?limit=15&page=0');
    if(responseData.isSuccess) {
      if(!refresh) {
        streamSocket.joinRoom(id);
      }
      return c.ChatMessage.fromJson(responseData.data);
    }
    return null;
  }
  static Future<bool> open(BuildContext context, String chatId,
      String appIcon,Locale locale,
      Map<String,dynamic>? userData,
      { String? domain,
        String? chatDomain}) async {
    PubdChat.context = context;
    showLoading(PubdChat.context!);
    await initializeDateFormatting();
    if(domain != null) {
      HTTPConnection.domain = domain;
    }
    if(chatDomain != null) {
      HTTPConnection.chatDomain = chatDomain;
    }
    ChatConnection.locale = locale;
    ChatConnection.buildContext = context;
    ChatConnection.appIcon = appIcon;
    bool result = await connectSocket(PubdChat.context!,chatId,appIcon,locale,userData,domain:domain);
    Navigator.of(PubdChat.context!).pop();
    if(result) {
      Rooms? rooms = await ChatConnection.initiate([chatId,ChatConnection.user!.data!.messageId!]);
      if(rooms != null) {
        await Navigator.of(PubdChat.context!,rootNavigator: true).push(
            MaterialPageRoute(builder: (context) => ChatScreen(data: rooms),settings: const RouteSettings(name: 'home_screen')));
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }
  static Future showLoading(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: Platform.isAndroid ? const CircularProgressIndicator() : const CupertinoActivityIndicator(),
              )
            ],
          );
        });
  }
}
