import Flutter
import UIKit

class EditorView: NSObject, FlutterPlatformView {
    private let editorVC: EditorViewUI
    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) {
  
        var path: String = ""
        var type: String = ""

        if let dict = args as? [String: Any] {
            // Validate main URL
            if let pathArg: String = dict["path"] as? String,
                let typeArg: String = dict["type"] as? String
            {
                path = pathArg
                type = typeArg

            } else {
                print("Not enough data")
            }

        }
        editorVC = EditorViewUI(frame: frame, type: type, path: path)
        super.init()

    }

    func view() -> UIView {
        return editorVC
    }

}

//   var flutterResult: FlutterResult?
//     var editorVC: EditorViewController?
//   var config = EditorConfiguration()
//   //  self.config.languageType = .system

//    var controller: UIViewController? {
//         return UIApplication.shared.delegate?.window??.rootViewController
//     }
//   public static func register(with registrar: FlutterPluginRegistrar) {
//     let channel = FlutterMethodChannel(
//       name: "bash_ios_editor_plugin", binaryMessenger: registrar.messenger())
//     let instance = BashIosEditorPlugin()
//     registrar.addMethodCallDelegate(instance, channel: channel)
//   }

// public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//     config.languageType = .english
//     if call.method == "openEditor" {
//         guard let args = call.arguments as? [String: Any],
//               let path = args["path"] as? String,
//               let type = args["type"] as? String else {
//             result(FlutterError(code: "INVALID_ARGUMENT", message: "Missing type or path", details: nil))
//             return
//         }
//         flutterResult = result
//         if type == "image" {
//             openImageEditor(path:path)
//         } else if type == "video" {
//             openVideoEditor(path:path)
//         } else {
//             result(FlutterError(code: "INVALID_TYPE", message: "Unsupported media type", details: nil))
//         }
//         // result(nil)
//     } else {
//         result(FlutterMethodNotImplemented)
//     }
// }

//   func openImageEditor( path: String) {

//     guard let image = UIImage(contentsOfFile: path) else {
//       print("⚠️ Failed to load image at path: \(path)")
//       return
//     }

//     editorVC = EditorViewController(.init(type: .image(image)), config:self.config)
//       editorVC?.modalPresentationStyle = .fullScreen
//       editorVC?.delegate = self
//       controller?.present(editorVC!, animated: true)
//   }
//   func openVideoEditor( path: String) {

//     let videoURL = URL(fileURLWithPath: path)

//       editorVC = EditorViewController(.init(type: .video(videoURL)), config:self.config)
//         editorVC?.modalPresentationStyle = .fullScreen
//         editorVC?.delegate = self
//         controller?.present(editorVC!, animated: true)
//   }

//     // ✅ This gets called when editing finishes
//   public  func editorViewController(_ editorViewController: EditorViewController, didFinish asset: EditorAsset) {

//       let editedURL = asset.result?.url
//       flutterResult?(editedURL?.path)
//              flutterResult = nil

//         editorViewController.dismiss(animated: true, completion: nil)
//     }
//     public    func editorViewController(_ editorViewController: EditorViewController, didFailed  error: EditorError) {
//         print("🚨 Export failed: \(error.localizedDescription)")
//               flutterResult?(FlutterError(code: "EXPORT_FAILED", message: error.localizedDescription, details: nil))
//               flutterResult = nil
//     }
//     // ✅ This gets called when user cancels
//   public  func editorViewController(didCancel editorViewController: EditorViewController) {
//       print("❌ Editor cancelled")
//            flutterResult?(nil)
//            flutterResult = nil
//            editorViewController.dismiss(animated: true, completion: nil)
//     }
// }
