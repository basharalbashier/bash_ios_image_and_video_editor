enum BashIosEditorTool {
  time,
  graffiti,
  chartlet,
  text,
  mosaic,
  filterEdit,
  filter,
  music,
  cropSize,
}

class BashIosEditorOptions {
  const BashIosEditorOptions({this.hiddenTools = const {}});

  final Set<BashIosEditorTool> hiddenTools;

  Map<String, dynamic> toMap() {
    return {
      'hiddenTools': hiddenTools.map((tool) => tool.name).toList(),
    };
  }

  bool get hasHiddenTools => hiddenTools.isNotEmpty;
}
