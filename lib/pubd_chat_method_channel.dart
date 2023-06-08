import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pubd_chat_platform_interface.dart';

/// An implementation of [PubdChatPlatform] that uses method channels.
class MethodChannelPubdChat extends PubdChatPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pubd_chat');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
