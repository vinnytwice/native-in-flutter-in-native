//
//  ViewController.swift
//  UiKitFlutter
//
//  Created by vincenzo calia on 16/10/23.
//

import UIKit
import Flutter

class ViewController: UIViewController, NSObject, FlutterPlatformViewFactory {

        
    private var messenger: FlutterBinaryMessenger
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }



    // override func viewDidLoad() {
    //     super.viewDidLoad()

    //     let buttonA = UIButton(type:UIButton.ButtonType.custom)
    //     buttonA.addTarget(self, action: #selector(showFlutterScreenA), for: .touchUpInside)
    //     buttonA.setTitle("Flutter Screen A", for: UIControl.State.normal)
    //     buttonA.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
    //     buttonA.backgroundColor = UIColor.systemGray5
    //     buttonA.setTitleColor(UIColor.systemBlue, for: .normal)
    //     buttonA.layer.cornerRadius = 8;
    //     self.view.addSubview(buttonA)
        
        
    //     let buttonB = UIButton(type:UIButton.ButtonType.custom)
    //     buttonB.addTarget(self, action: #selector(showFlutterScreenB), for: .touchUpInside)
    //     buttonB.setTitle("Flutter Screen B", for: UIControl.State.normal)
    //     buttonB.frame = CGRect(x: 80.0, y: 260.0, width: 160.0, height: 40.0)
    //     buttonB.backgroundColor = UIColor.systemGray5
    //     buttonB.setTitleColor(UIColor.systemBlue, for: .normal)
    //     buttonB.layer.cornerRadius = 8;
    //     self.view.addSubview(buttonB)

    // }

    
    
    @objc func flutterButtonBTapped() {
        // Implement your native functionality here
        print("flutterButtonBTapped - perform your native action here")
        let flutterEngineForButtonB = (UIApplication.shared.delegate as! AppDelegate).flutterEngineForButtonB;
        let methodChannelButtonB = FlutterMethodChannel(name: "flutter_button_b", binaryMessenger: flutterEngineForButtonB.binaryMessenger);
        methodChannelButtonB.setMethodCallHandler ({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "test":

                print("flutter button b method called was test, with arguments: \(String(describing: call.arguments))");
            default:
                print("flutter button a method called default");
            }
        });

        
    }

    
    
    

    // func presentViewController(vc: FlutterViewController){
    //     vc.modalPresentationStyle = .overCurrentContext;
    //     present(vc, animated: true);
    // }
    
    // func dismissViewController(vc: FlutterViewController){
        
    //     vc.dismiss(animated: true);
    // }




}

