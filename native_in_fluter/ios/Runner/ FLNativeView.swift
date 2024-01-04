//
//   FLNativeView.swift
//  Runner
//
//  Created by Vincenzo Calia on 21/12/23.
//

import Flutter
import UIKit


// MARK: DYNAMIC VC SELECTION
enum  ViewControllerToPresent {

    static var viewController = ViewController()
    static var viewController2 = ViewController2()

}

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
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
        print("DynamicNativeViewFactory init")
        return NativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class NativeView: NSObject, FlutterPlatformView {
    private var _view: UIView = UIView();
    

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
         print("DynamicNativeView init")
        //MARK: crate a switch to choose the vc to be shown
        if let params = args as? [String:AnyObject] {
            var screen: String = params["screen"] as! String;
            
//            switch screen {
//            case "ViewController":
//                ViewControllerToPresent.viewController.buttonTitleA = params["param 1"] as! String;
//                ViewControllerToPresent.viewController.buttonTitleB = params["param 2"] as! String;
//                _view = ViewControllerToPresent.viewController.view
//            case "ViewController2":
//                ViewControllerToPresent.viewController2.buttonTitleA = params["param 1"] as! String;
//                ViewControllerToPresent.viewController2.buttonTitleB = params["param 2"] as! String;
//                _view = ViewControllerToPresent.viewController2.view
//            default:
//                print("")
//
//            }
            if let vc = ViewControllerGetter(rawValue: screen)?.getViewController(with: params) {
                _view = vc.view;
            }
//            _view = vc!.view;
        }
        super.init()
    }

    func view() -> UIView {
        return _view
    }
}






