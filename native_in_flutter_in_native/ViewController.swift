//
//  ViewController.swift
//  native_in_flutter_in_native
//
//  Created by Vincenzo Calia on 03/01/24.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonA = UIButton(type:UIButton.ButtonType.custom)
        buttonA.addTarget(self, action: #selector(showFlutterScreen), for: .touchUpInside)
        buttonA.setTitle("Show flutter", for: UIControl.State.normal)
        buttonA.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        buttonA.backgroundColor = UIColor.systemGray5
        buttonA.setTitleColor(UIColor.systemBlue, for: .normal)// title.tintColor = UIColor.systemBlue
        buttonA.layer.cornerRadius = 8;
        self.view.addSubview(buttonA)
    }
    
    @objc func showFlutterScreen() {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine;
        // set the flutter engine view controller to nil before creating a flutter view controller with the flutter engine
        flutterEngine.viewController = nil;
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        let flutterEngine = appDelegate.engines.makeEngine(withEntrypoint: "main", libraryURI:"package:native_in_fluter/main.dart")
//        GeneratedPluginRegistrant.register(with: flutterEngine)

        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil);
        let methodChannelA = FlutterMethodChannel(name: "native_viewer_platform_channel",
                                                  binaryMessenger: flutterEngine.binaryMessenger);


        methodChannelA.setMethodCallHandler({ //[weak self]
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            print("\(String (describing: call.method)) Native vc method invocation received on \"native_viewer_platform_channel\" method channel with arguments:  \(String(describing: call.arguments))" );

            switch(call.method) {
            case "close":
                self.dismissViewController(vc: flutterViewController)
            default:
                print("Unrecognized method name: \(call.method)")
            }
        })
        presentViewController(vc: flutterViewController);
        
      }


    func presentViewController(vc: FlutterViewController){
        vc.modalPresentationStyle = .overCurrentContext;
        present(vc, animated: true);
    }
    
    func dismissViewController(vc: FlutterViewController){
        vc.dismiss(animated: true);
    }




}

