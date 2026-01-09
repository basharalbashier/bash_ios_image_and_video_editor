import 'bash_ios_editor_plugin_platform_interface.dart';
export 'src/editor_view.dart';
class BashIosEditorPlugin {
  Future<String?> openImageEditor(String imagePath) {
    return BashIosEditorPluginPlatform.instance.openImageEditor(imagePath);
  }

  Future<String?> openVideoEditor(String videoPath) {
    return BashIosEditorPluginPlatform.instance.openVideoEditor(videoPath);
  }
}
