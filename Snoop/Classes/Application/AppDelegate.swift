//
//  AppDelegate.swift
//  Snoop
//
//  Created by Sergey Kim on 19.10.2020.
//

import UIKit

typealias Localized = R.string.localizable
public typealias PhotosClosure = (Result<[UIImage], Error>) -> Void
public typealias EmptyClosure = () -> Void
public typealias AClosure = (AData) -> Void

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: ApplicationNavCoordinator!
    var dependencies: ApplicationDependenceProvider!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configure()
        coordinator.applicationLaunched()
        return true
    }

    private func configure() {
        dependencies = ApplicationDependenceProvider()
        dependencies.configure()

        coordinator = resolve()

        let rootRouter: RootRoutable = resolve()
        rootRouter.configure(window: window)
        
        // feature 2
    }
}

