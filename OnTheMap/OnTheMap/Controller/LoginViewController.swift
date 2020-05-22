//
//  ViewController.swift
//  OnTheMap
//
//  Created by Fazakas Loránd on 2020. 04. 16..
//  Copyright © 2020. Lorand Fazakas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if (!emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty) {
            setLoggingInAnimator(true)
            UdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
        } else {
            showFailure(title: "Login Failed", message: "Username and password cannot be empty")
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        UIApplication.shared.open(UdacityClient.Endpoints.signUp.url, options: [:], completionHandler: nil)
    }
    
     func handleLoginResponse(success: Bool, error: Error?) {
           setLoggingInAnimator(false)
           if success {
               performSegue(withIdentifier: "completeLogin", sender: nil)
           } else {
               showFailure(title: "Login Failed", message: error?.localizedDescription ?? "")
           }
       }
    
    func setLoggingInAnimator(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        signUpButton.isEnabled = !loggingIn
    }
    
}

