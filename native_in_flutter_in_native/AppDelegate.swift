//
//  AppDelegate.swift
//  native_in_flutter_in_native
//
//  Created by Vincenzo Calia on 03/01/24.
//

import UIKit
import Flutter
import FlutterPluginRegistrant


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var flutterEngine = FlutterEngine(name: "my flutter engine");
//    let engines = FlutterEngineGroup(name: "multiple-flutters", project: nil)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        flutterEngine.run(withEntrypoint: "main", libraryURI: "package:native_in_fluter/main.dart");
        
        GeneratedPluginRegistrant.register(with: flutterEngine);


        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

