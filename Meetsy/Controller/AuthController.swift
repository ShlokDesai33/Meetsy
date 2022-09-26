//
//  AuthController.swift
//  Meetsy
//
//  Created by Shlok Desai on 15/08/22.
//

import UIKit

class AuthController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var meetsyLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameInputField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // init the name text field
        nameInputField.delegate = self
        nameInputField.keyboardType = UIKeyboardType.alphabet
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Setting the Y position for Leetsy logo
        if UIDevice.current.hasNotch {
            meetsyLogoConstraint.constant = 20
        } else {
            meetsyLogoConstraint.constant = 10
        }

    }
    
    //
    // Custom log in
    //
    
    @IBAction func login(_ sender: Any) {
        // first set name and link attributes
        guard let fullname = nameInputField.text else {
            // replace with alert
            return
        }
        
        if (fullname == "") {
            // replace with alert
            return
        }
        
        UDM.shared.setName(name: fullname)
        UDM.shared.setLoggedInStatus(status: true)

        // facilitate view change
        let profileStroyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = profileStroyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)

    }
    
    @IBAction func logout(_ sender: Any) {
        let profileStroyboard = UIStoryboard(name: "AuthStoryboard", bundle: nil)
        //Creating an instance of the viewcontroller to go to.
        let vc = profileStroyboard.instantiateViewController(withIdentifier: "AuthController") as! AuthController
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate
          else {
            return
          }
        
        UDM.shared.setLoggedInStatus(status: false)
        
        sceneDelegate.window?.rootViewController = vc
        sceneDelegate.window?.makeKeyAndVisible()
        dismiss(animated: false)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}
