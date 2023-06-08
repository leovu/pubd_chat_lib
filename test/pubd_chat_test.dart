import 'package:flutter_test/flutter_test.dart';
import 'package:pubd_chat/pubd_chat.dart';
import 'package:pubd_chat/pubd_chat_platform_interface.dart';
import 'package:pubd_chat/pubd_chat_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPubdChatPlatform
    with MockPlatformInterfaceMixin
    implements PubdChatPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PubdChatPlatform initialPlatform = PubdChatPlatform.instance;

  test('$MethodChannelPubdChat is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPubdChat>());
  });

  test('getPlatformVersion', () async {
    PubdChat pubdChatPlugin = PubdChat();
    MockPubdChatPlatform fakePlatform = MockPubdChatPlatform();
    PubdChatPlatform.instance = fakePlatform;

    expect(await pubdChatPlugin.getPlatformVersion(), '42');
  });
}
