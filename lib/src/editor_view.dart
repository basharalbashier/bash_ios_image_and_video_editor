import 'dart:developer';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditorView extends StatelessWidget {
  const EditorView({required this.path, super.key});
  final List<String> path;
  @override
  Widget build(BuildContext context) {
    return PreparMedia(media: path);
  }
}

class PreparMedia extends StatefulWidget {
  final List<String> media;
  const PreparMedia({required this.media, super.key});

  @override
  State<PreparMedia> createState() => _PreparMediaState();
}

class _PreparMediaState extends State<PreparMedia> with AutomaticKeepAliveClientMixin{
  final List<PageStorageBucket> _buckets = [];
  final Map<int, bool> _initializedViews = {};

  @override
  void initState() {
    super.initState();
    // Initialize a bucket for each page
    _buckets.addAll(List.generate(widget.media.length, (i) => PageStorageBucket()));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAlive
    
    return PageView.builder(
      scrollBehavior: ScrollBehavior(),
      itemCount: widget.media.length,
      itemBuilder: (context, index) {
        return KeepAliveWrapper(
          keepAlive: true,
          child: PageStorage(
            bucket: _buckets[index],
            child: _buildPlatformView(index),
          ),
        );
      },
    );
  }

  Widget _buildPlatformView(int index) {
    return Visibility(
      maintainState: true, // Crucial for preserving state
      visible: true, // Your visibility logic
      child: UiKitView(
        key: ValueKey('editor_$index'), // Unique key per view
        onPlatformViewCreated: (id) {
          _initializedViews[index] = true;
          debugPrint('Created platform view $id for index $index');
        },
        viewType: 'bash_ios_editor',
        creationParams: {
          'path': widget.media[index],
          'type': getType(widget.media[index]),
        },
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }

  bool _shouldShow(int index) {
    // Show current page + adjacent pages for better performance
    final currentPage = PageStorage.of(context).readState(context) ?? 0;
    return (index - currentPage).abs() <= 1;
  }
}

// Reusable KeepAlive wrapper
class KeepAliveWrapper extends StatefulWidget {
  final bool keepAlive;
  final Widget child;

  const KeepAliveWrapper({
    super.key,
    required this.keepAlive,
    required this.child,
  });

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> 
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
String getType(String path) => lookupMimeType(path).toString().split("/")[0];

