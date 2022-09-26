//
//  editUsernameController.swift
//  LINK
//
//  Created by APPLE on 19/07/22.
//

import UIKit

class EditUsernameController: UIViewController{

    private var arrayOfCells: [EditUsernameTableCell] = []
    
    
    @IBOutlet weak var SocialMedialogo : UIImageView!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var platformName : UILabel!
    
    var currentUsername: String!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var SocialsDataSource : [Social]!
    var index: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        
        platformName.text = SocialsDataSource[index].platform
        SocialMedialogo.image = UIImage(named: SocialsDataSource[index].platform as! String)
        usernameTF.text = currentUsername
        
        //platformName.text = platformNameTemp
        
        //SocialMedialogo.image = socialMediaLogoTemp
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "DidAddUsernames")
        
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func backButton(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @IBAction func saveUsernames(_ sender: Any) {
        
        //TODO: Save usernames
        
        //Checks if any Textfield is non-empty and changes DidAddUsernames value to true
        
//        for i in 0..<arrayOfCells.count {
//            if arrayOfCells[i].username.hasText == true{
//                UserDefaults.standard.set(true, forKey: "DidAddUsernames")
//            } else{
//                continue
//            }
//        }
        SocialsDataSource[index].username = usernameTF.text
        do{
            try context.save()
        }
        catch{
            
        }
        
        
        
        
            //Posts a notification to call Collection View reload data upon dismissing screen
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

        
        dismiss(animated: true)
    }
    
}

