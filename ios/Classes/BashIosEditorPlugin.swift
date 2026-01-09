import Flutter
import HXPHPicker
import UIKit

public class BashIosEditorPlugin: NSObject, FlutterPlugin,EditorViewControllerDelegate {
  var flutterResult: FlutterResult?
    var editorVC: EditorViewController?
  var config = EditorConfiguration()
  //  self.config.languageType = .system

   var controller: UIViewController? {
        return UIApplication.shared.delegate?.window??.rootViewController
    }
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "bash_ios_editor_plugin", binaryMessenger: registrar.messenger())
    let instance = BashIosEditorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    config = EditorConfiguration()
    config.languageType = .english
    if call.method == "openEditor" {
        guard let args = call.arguments as? [String: Any],
              let path = args["path"] as? String,
              let type = args["type"] as? String else {
            result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing type or path", details: nil))
            return
        }
        let options = args["options"] as? [String: Any]
        applyOptions(options)
        flutterResult = result
        if type == "image" {
            openImageEditor(path:path)
        } else if type == "video" {
            openVideoEditor(path:path)
        } else {
            result(FlutterError(code: "INVALID_TYPE", message: "Unsupported media type", details: nil))
        }
        // result(nil)
    } else {
        result(FlutterMethodNotImplemented)
    }
}

  private func applyOptions(_ options: [String: Any]?) {
      guard let options = options else { return }
      if let hiddenTools = options["hiddenTools"] as? [String],
         !hiddenTools.isEmpty {
          let hiddenSet = Set(hiddenTools.compactMap { toolType(from: $0) })
          guard !hiddenSet.isEmpty else { return }
          let filtered = EditorConfiguration.ToolsView.default.toolOptions.filter {
              !hiddenSet.contains($0.type)
          }
          config.toolsView = .init(toolOptions: filtered)
      }
  }

  private func toolType(from rawValue: String) -> EditorConfiguration.ToolsView.Options.`Type`? {
      let key = rawValue.replacingOccurrences(of: "_", with: "").lowercased()
      switch key {
      case "time":
          return .time
      case "graffiti":
          return .graffiti
      case "chartlet", "emoji", "emojis":
          return .chartlet
      case "text":
          return .text
      case "mosaic":
          return .mosaic
      case "filteredit":
          return .filterEdit
      case "filter", "filters":
          return .filter
      case "music":
          return .music
      case "cropsize":
          return .cropSize
      default:
          return nil
      }
  }


  func openImageEditor( path: String) {
  
    guard let image = UIImage(contentsOfFile: path) else {
      print("⚠️ Failed to load image at path: \(path)")
      return
    }


  
    editorVC = EditorViewController(.init(type: .image(image)), config:self.config)
      editorVC?.modalPresentationStyle = .fullScreen
      editorVC?.delegate = self
      controller?.present(editorVC!, animated: true)
  }
  func openVideoEditor( path: String) {
  
   

    let videoURL = URL(fileURLWithPath: path)


      editorVC = EditorViewController(.init(type: .video(videoURL)), config:self.config)
        editorVC?.modalPresentationStyle = .fullScreen
        editorVC?.delegate = self
        controller?.present(editorVC!, animated: true)
  }

    // ✅ This gets called when editing finishes
  public  func editorViewController(_ editorViewController: EditorViewController, didFinish asset: EditorAsset) {

      let editedURL = asset.result?.url
      flutterResult?(editedURL?.path)
             flutterResult = nil

        editorViewController.dismiss(animated: true, completion: nil)
    }
    public    func editorViewController(_ editorViewController: EditorViewController, didFailed  error: EditorError) {
        print("🚨 Export failed: \(error.localizedDescription)")
              flutterResult?(FlutterError(code: "EXPORT_FAILED", message: error.localizedDescription, details: nil))
              flutterResult = nil
    }
    // ✅ This gets called when user cancels
  public  func editorViewController(didCancel editorViewController: EditorViewController) {
      print("❌ Editor cancelled")
           flutterResult?(nil)
           flutterResult = nil
           editorViewController.dismiss(animated: true, completion: nil)
    }
}

