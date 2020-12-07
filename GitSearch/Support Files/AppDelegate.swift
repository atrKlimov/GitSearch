//
//  AppDelegate.swift
//  GitSearch
//
//  Created by Mac on 12/5/20.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dependenciesHolder: DependenciesHolder!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.dependenciesHolder = DependenciesHolder()
        let injector = dependenciesHolder.injector()
        self.window = UIWindow()
        let rootController = UINavigationController(rootViewController: SearchBuilder.build(injector: injector))
        window?.rootViewController = rootController
        
        window?.makeKeyAndVisible()
        return true
    }

}
