import 'dart:io';
import 'package:bash_ios_editor_plugin/bash_ios_editor_plugin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: EditorScreen());
  }
}

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final BashIosEditorPlugin editor = BashIosEditorPlugin();
  VideoPlayerController? _controller;
  String? imagePath;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bash iOS Editor Plugin Example')),
      body: Column(
        children: [
          if (_controller != null && _controller!.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            ),
          if (imagePath != null)
            Image.file(File(imagePath!), height: 200, width: double.infinity),
          Center(
            child: ElevatedButton(
              onPressed: _onPressed,
              child: Text("Pick Image or Video"),
            ),
          ),
        ],
      ),
    );
  }

  void initPlayer({required String path}) {
    _controller = VideoPlayerController.file(File(path));
    _controller!.initialize().then((_) {
      _controller!.play();
      setState(() {});
    });
  }

  void _onPressed() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final List<XFile>? media = await picker.pickMultipleMedia().then((
      List<XFile>? value,
    ) {
      if (value != null && value.isNotEmpty) {
        return value;
      }
      return null;
    });
    if (media == null) {
      return;
    }

    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (c, n, _) => Scaffold(
              // appBar: AppBar(backgroundColor: Colors.black,),
              backgroundColor: Colors.black,
              body: EditorView(
                path: media.map((toElement) => toElement.path).toList(),
              ),
            ),
      ),
    );

    // if (path != null) {
    //   if (isVideo) {
    //     initPlayer(path: path);
    //     return;
    //   }
    //   imagePath = path;
    //   setState(() {});
    // }
  }
}
