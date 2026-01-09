# bash_ios_editor_plugin

A Flutter plugin that integrates the powerful iOS photo and video  editor [HXPHPicker](https://github.com/SilenceLove/HXPHPicker), enabling native media editing capabilities within your Flutter apps.



## ✨ Features

- 🎞️ Video and image editing tools
- 🖼️ Crop, rotate, filter, draw, mosaic & more
- 🌐 Localization support
- 📦 Easy integration with Flutter

## ✅ Usage

```dart
const options = BashIosEditorOptions(
  hiddenTools: {BashIosEditorTool.chartlet, BashIosEditorTool.filter},
);

final editor = BashIosEditorPlugin();
final editedPath = await editor.openImageEditor(
  imagePath,
  options: options,
);
```

Available tools:
`time`, `graffiti`, `chartlet`, `text`, `mosaic`, `filterEdit`, `filter`,
`music`, `cropSize`.


## 🔧 Contributing

Contributions are warmly welcome!
Whether it’s fixing bugs, improving documentation, or adding new features — I’d love to have your help.

If you’re interested in contributing:

1- Fork the repository

2- Create a new branch

3- Make your changes

4- Submit a pull request 🙌

Feel free to open issues or suggestions as well — collaboration is encouraged!


🙏 Special Thanks
This plugin wraps the excellent native iOS library HXPHPicker by @SilenceLove.
Thank you for the incredible work on this powerful media picker and editor!
