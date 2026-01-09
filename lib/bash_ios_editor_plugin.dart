export 'src/editor_options.dart';

import 'bash_ios_editor_plugin_platform_interface.dart';
import 'src/editor_options.dart';

class BashIosEditorPlugin {
  Future<String?> openImageEditor(
    String imagePath, {
    BashIosEditorOptions? options,
  }) {
    return BashIosEditorPluginPlatform.instance.openImageEditor(
      imagePath,
      options: options,
    );
  }

  Future<String?> openVideoEditor(
    String videoPath, {
    BashIosEditorOptions? options,
  }) {
    return BashIosEditorPluginPlatform.instance.openVideoEditor(
      videoPath,
      options: options,
    );
  }
}
