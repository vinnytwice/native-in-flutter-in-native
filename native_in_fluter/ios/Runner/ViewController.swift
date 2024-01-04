//
//  ViewController.swift
//  UiKitFlutter
//
//  Created by vincenzo calia on 16/10/23.
//

import UIKit
import Flutter

class ViewController: UIViewController {
    public var buttonTitleA: String?
    public var buttonTitleB: String?
    
     override func viewDidLoad() {
         
         super.viewDidLoad()

         let buttonA = UIButton(type:UIButton.ButtonType.custom)
         buttonA.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
         buttonA.setTitle(buttonTitleA ?? "Flutter Screen A", for: UIControl.State.normal)
         buttonA.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
         buttonA.backgroundColor = UIColor.systemGray5
         buttonA.setTitleColor(UIColor.systemBlue, for: .normal)
         buttonA.layer.cornerRadius = 8;
         self.view.addSubview(buttonA)
        
        
         let buttonB = UIButton(type:UIButton.ButtonType.custom)
         buttonB.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
         buttonB.setTitle(buttonTitleB ?? "Flutter Screen B", for: UIControl.State.normal)

         buttonB.frame = CGRect(x: 80.0, y: 260.0, width: 160.0, height: 40.0)
         buttonB.backgroundColor = UIColor.systemGray5
         buttonB.setTitleColor(UIColor.systemBlue, for: .normal)
         buttonB.layer.cornerRadius = 8;
         self.view.addSubview(buttonB);
         
         
         
         
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         if let methodChannel = appDelegate.nativeViewerPlatformCahannel {
             
             methodChannel.invokeMethod("swift_to_flutter", arguments: ["ViewController method channel instantiated"]);

             
//              methodChannel.setMethodCallHandler({ //[weak self]
//                  (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
// //                 print("\(String (describing: call.method)) method invocation received on \"ViewController\" method channel with arguments:  \(String(describing: call.arguments))" );

//                  switch(call.method) {
//                  case "test":
// //                     print("Received method name: \(call.method)")
//                      methodChannel.invokeMethod("swift_to_flutter", arguments: ["response to method call received from viewController 1"]);
//                  default:
//                      print("Unrecognized method name: \(call.method)")
//                  }
//              })
         }


         
         
         
     }



    
    @objc func dismissViewController(vc: FlutterViewController){
         vc.dismiss(animated: true);
     }
}

