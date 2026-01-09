import HXPHPicker
import UIKit
import Flutter

class EditorViewUI: UIView, EditorViewControllerDelegate {
    var editorVC: EditorViewController?
    var config = EditorConfiguration()
//    weak var parentViewController: UIViewController?
    
    init(frame: CGRect, type: String, path: String) {
        super.init(frame: frame)
//        self.parentViewController = window?.rootViewController as! FlutterViewController
        config.languageType = .english
        
        if type == "image" {
            guard let image = UIImage(contentsOfFile: path) else {
                print("Failed to load image at path: \(path)")
                return
            }
            
            editorVC = EditorViewController(.init(type: .image(image)), config: config)
            
        } else if type == "video" {
            let videoURL = URL(fileURLWithPath: path)
            guard FileManager.default.fileExists(atPath: videoURL.path) else {
                print("Video file not found at path: \(path)")
                return
            }
            
            editorVC = EditorViewController(.init(type: .video(videoURL)), config: config)
        }
        
        setupEditor()
    }
    
    private func setupEditor() {
        guard let editor = editorVC else {
            print("EditorViewController not initialized")
            return
        }
        
        editor.delegate = self
        editor.modalPresentationStyle = .fullScreen
        
        // Add as child view controller
//        self.addChild(editor)
        editor.view.frame = self.bounds
        self.addSubview(editor.view)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        editorVC?.willMove(toParent: nil)
        editorVC?.view.removeFromSuperview()
        editorVC?.removeFromParent()
    }
    
    public  func editorViewController(_ editorViewController: EditorViewController, didFinish asset: EditorAsset) {

        let editedURL = asset.result?.url
//        flutterResult?(editedURL?.path)
//               flutterResult = nil
        print(editedURL?.path)
          editorViewController.dismiss(animated: true, completion: nil)
      }
      public    func editorViewController(_ editorViewController: EditorViewController, didFailed  error: EditorError) {
//          print("🚨 Export failed: \(error.localizedDescription)")
//                flutterResult?(FlutterError(code: "EXPORT_FAILED", message: error.localizedDescription, details: nil))
//                flutterResult = nil
      }
      // ✅ This gets called when user cancels
    public  func editorViewController(didCancel editorViewController: EditorViewController) {
        print("❌ Editor cancelled")
//             flutterResult?(nil)
//             flutterResult = nil
             editorViewController.dismiss(animated: true, completion: nil)
      }
}
