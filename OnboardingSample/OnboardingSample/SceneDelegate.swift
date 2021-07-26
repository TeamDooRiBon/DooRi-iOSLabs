//
//  SceneDelegate.swift
//  OnboardingSample
//
//  Created by taehy.k on 2021/07/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        guard let onboardingVC = UIStoryboard(name: "OnboardingStoryboard", bundle: nil).instantiateViewController(identifier: "OnboardingViewController") as? OnboardingViewController else { return }
        window?.rootViewController = onboardingVC
        window?.makeKeyAndVisible()
    }
}

