//
//  ProvidersController.swift
//  Meetsy
//
//  Created by Shlok Desai on 16/08/22.
//

import UIKit
import GoogleSignIn

class ProvidersController: UIViewController {

    let signInConfig = GIDConfiguration(clientID: "833952923060-840jpk8civku5916djm1m3f859kuj71h.apps.googleusercontent.com", serverClientID: "833952923060-3i9nt0vc6hht95f403tksgqp7qt9606r.apps.googleusercontent.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //
    // Google Sign in
    //
    
    @IBAction func googleSignIn(sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            let emailAddress = user.profile?.email
            print (emailAddress!)
            let fullName = user.profile?.name
            print(fullName!)
            // let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            
            user.authentication.do { authentication, error in
                guard error == nil else { return }
                guard let authentication = authentication else { return }

                let idToken = authentication.idToken
                print(idToken!)
                // Send ID token to backend.
            }
            
            // If sign in succeeded, display the app's main content View.
            //If token exists directly to app
            // TODO: Set UDMs in this if statement, following inside if statement
            
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = authStoryboard.instantiateViewController(withIdentifier: "ProvidersController") as! ProvidersController
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: false)
            
            
            
            //If token doesnt exist show Auth Controllers
            
            let authStoryboard = UIStoryboard(name: "AuthStoryboard", bundle: nil)
            let vc = authStoryboard.instantiateViewController(withIdentifier: "AuthController") as! AuthController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
            
            
        }
    }
    
    @IBAction func googleSignOut(sender: Any) {
      GIDSignIn.sharedInstance.signOut()
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
