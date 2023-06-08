import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pubd_chat_method_channel.dart';

abstract class PubdChatPlatform extends PlatformInterface {
  /// Constructs a PubdChatPlatform.
  PubdChatPlatform() : super(token: _token);

  static final Object _token = Object();

  static PubdChatPlatform _instance = MethodChannelPubdChat();

  /// The default instance of [PubdChatPlatform] to use.
  ///
  /// Defaults to [MethodChannelPubdChat].
  static PubdChatPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PubdChatPlatform] when
  /// they register themselves.
  static set instance(PubdChatPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
