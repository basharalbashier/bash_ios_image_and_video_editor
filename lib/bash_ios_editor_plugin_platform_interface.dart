import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bash_ios_editor_plugin_method_channel.dart';
import 'src/editor_options.dart';

abstract class BashIosEditorPluginPlatform extends PlatformInterface {
  /// Constructs a BashIosEditorPluginPlatform.
  BashIosEditorPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static BashIosEditorPluginPlatform _instance =
      MethodChannelBashIosEditorPlugin();

  /// The default instance of [BashIosEditorPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelBashIosEditorPlugin].
  static BashIosEditorPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BashIosEditorPluginPlatform] when
  /// they register themselves.
  static set instance(BashIosEditorPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> openImageEditor(
    String imagePath, {
    BashIosEditorOptions? options,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> openVideoEditor(
    String videoPath, {
    BashIosEditorOptions? options,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
