//
//  SceneDelegate.swift
//  RomanGushchik_Homework17
//
//  Created by admin on 26.05.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var passwordTextField: UITextField!
    var checkPasswordTextField: UITextField!
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        if UserDefaults.standard.string(forKey: "SavePassword") != nil {
            enterPassword()
        } else {
            setPassword()
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        guard let viewController = window?.rootViewController
            else {
            return
        }
        viewController.dismiss(animated: true)
    }


}

extension SceneDelegate {
    
    func setPassword() {
        guard let viewController = window?.rootViewController
            else {
            return
        }
        let securityMessage = UIAlertController(title: "Security", message: "Do you want to set up a password?", preferredStyle: .alert)
        securityMessage.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            self.passwordTextField = textField
            
        }
        let setPasswordButton = UIAlertAction(title: "Set Password", style: .cancel) { _ in
            guard let password = self.passwordTextField.text
            else {
                return
            }
            UserDefaults.standard.set(password, forKey: "SavePassword")
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        securityMessage.addAction(setPasswordButton)
        securityMessage.addAction(cancelButton)
        viewController.present(securityMessage, animated: true)
    }
    
    func enterPassword() {
        guard let viewController = window?.rootViewController
            else {
            return
        }
        let unlockAcces = UIAlertController(title: "Acces denied", message: "Please, enter your password.", preferredStyle: .alert)
        unlockAcces.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            self.checkPasswordTextField = textField
            
        }
        let confirmPasswordButton = UIAlertAction(title: "Ok", style: .cancel) { _ in
            guard let enteredPassword = self.checkPasswordTextField.text
            else {
                return
            }
            if UserDefaults.standard.string(forKey: "SavePassword") != enteredPassword {
                let wrongMessage = UIAlertController(title: "Error", message: "Password is wrong", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Ok", style: .cancel) { _ in
                    self.checkPasswordTextField.text = ""
                    viewController.present(unlockAcces, animated: true)
                }
                wrongMessage.addAction(okButton)
                viewController.present(wrongMessage, animated: true)
            } else {
                return
            }
        }
        unlockAcces.addAction(confirmPasswordButton)
        viewController.present(unlockAcces, animated: true)
    }
}

