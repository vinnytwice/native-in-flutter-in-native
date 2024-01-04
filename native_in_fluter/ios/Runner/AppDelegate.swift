import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var nativeViewerPlatformCahannel: FlutterMethodChannel?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
      nativeViewerPlatformCahannel = FlutterMethodChannel(name: "native_viewer_platform_channel",binaryMessenger: controller.binaryMessenger);
      nativeViewerPlatformCahannel?.invokeMethod("swift_to_flutter", arguments: ["AppDelegate method channel instantiated"]);
      
     GeneratedPluginRegistrant.register(with: self);
      // GeneratedPluginRegistrant.register(withRegistry: self);

      // MARK: NATIVE in Flutter setup

      weak var registrar = self.registrar(forPlugin: "plugin-name");
      let factory = FLNativeViewFactory(messenger: registrar!.messenger())
      self.registrar(forPlugin: "<plugin-name>")!.register(
          factory,
          withId: "<platform-view-type>")
          

      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
