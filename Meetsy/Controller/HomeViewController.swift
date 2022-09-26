//
//  ViewController.swift
//  LINK
//
//  Created by APPLE on 27/05/22.
// Controller for the main home view

import UIKit
import CoreData

class HomeViewController: UIViewController{
 
    //All connection outlets
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var meetsyLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var numberOfLinks: UILabel!
    var segueCurrentUsername: String!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var socialsDataSource: [Social]! = []
    var indexSocial : Int!
    
    
    //datasources for the cells (hardcoded right now)
    //TODO: Change data sources to a single object array
    
   
    @IBAction func linkUpButton(_ sender: Any) {

        //Button to change viewcontrollers on pressing link up
        let profileStroyboard = UIStoryboard(name: "ProfilePage", bundle: nil)
        //Creating an instance of the viewcontroller to go to.
        let vc = profileStroyboard.instantiateViewController(withIdentifier: "ProfilePageController") as! ProfilePageController
        //Presenting the controller in the style we want
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)

    }
    
    //TODO: Change to a label and img stack
    @IBAction func linkHeaderButton(_ sender: Any){
       tabBarController?.selectedIndex = 1
    }
    
    //Set meetsylogo properly
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Setting the Y position for Leetsy logo
        if UIDevice.current.hasNotch {
            meetsyLogoConstraint.constant = 20
            settingButtonConstraint.constant = 20
        } else {
            meetsyLogoConstraint.constant = 10
            settingButtonConstraint.constant = 10
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest : NSFetchRequest<Social> = Social.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(fetchRequest)
            
            for social in result{
                socialsDataSource.append(social)
                collectionView.reloadData()
            }
          
           print("\n \(result)")
            
        }
        catch{
            print("couldnt fetch")
        }
    }
    
    //Initalise the viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set user details on the Home page
        displayName.text = UDM.shared.getName()
        numberOfLinks.text = String("\(UDM.shared.getNoLinks()) Links")
        
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        //Defining the delegate and datasource of the collection view as self(homeviewcontroller)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.backgroundColor = UIColor.white.cgColor
        
        //remove safe area insets from top
        view.insetsLayoutMarginsFromSafeArea = false
        
        //register XIB file thahas the style for the cell
        let nib = UINib(nibName: "SocialMediaCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "SocialMediaCell")
        
        let nib2 = UINib(nibName: "AddMoreCollectionCell", bundle: nil)
        self.collectionView.register(nib2, forCellWithReuseIdentifier: "AddMoreCollectionCell")
        
        
        UserDefaults.standard.set(false, forKey: "DidAddUsernames")
        
        //Dummy code no use rn.
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        
       
        


   
        
        
        
    }

}
//Extension of HomeviewController to have methods in DataSource
//Necessary for making collection view

extension HomeViewController: UICollectionViewDataSource{

    //Number of items (social medias to share) may vary in future
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(socialsDataSource == nil){
            return 1
        }else{
            return socialsDataSource.count + 1
            
        }
    }
    //Number of sections always 1 in our case
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    //Defines cell for different index paths. This is where we create instances of cells.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Last index for collection view
        let lastindex = collectionView.numberOfItems(inSection: collectionView.numberOfSections - 1)
        
        //Check if its the last index and put add more cell
        if(indexPath.row == lastindex - 1 ){
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "AddMoreCollectionCell", for: indexPath) as! AddMoreCollectionCell

            cell2.mainView.layer.borderWidth = 1
            cell2.mainView.layer.cornerRadius = 10
            cell2.mainView.backgroundColor = UIColor.white
            
            //Stylising the cell
            cell2.mainView.layer.borderWidth = 1
            cell2.mainView.layer.cornerRadius = 10
                //cell.mainView.layer.borderColor =
            cell2.mainView.backgroundColor = UIColor.white
            
            cell2.tag = 2

            return cell2
        }
       
        //Check if datasource is nil or empty
        if (socialsDataSource != nil && socialsDataSource.count > 0){
            
           
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialMediaCell", for: indexPath) as! SocialMediaCell

            //Configuring all the elements from datasource


            cell.socialMediaLogo.image = UIImage(named: socialsDataSource[indexPath.row].platform!)
            cell.socialMediaName.text = socialsDataSource[indexPath.row].platform
            
            cell.username.text = String("@\(socialsDataSource[indexPath.row].username as! String)")
           
            cell.mainView.layer.borderWidth = 1
            
            cell.mainView.layer.cornerRadius = 10
            cell.mainView.backgroundColor = UIColor.white
            
            //Stylising the cell
            cell.mainView.layer.borderWidth = 1
            cell.mainView.layer.cornerRadius = 10
                //cell.mainView.layer.borderColor =
            cell.mainView.backgroundColor = UIColor.white
            
            cell.tag = 1

            return cell
            
        }//If datasource is empty
        else {
           
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "AddMoreCollectionCell", for: indexPath) as! AddMoreCollectionCell

            cell2.mainView.layer.borderWidth = 1
            cell2.mainView.layer.cornerRadius = 10
            cell2.mainView.backgroundColor = UIColor.white
            
            //Stylising the cell
            cell2.mainView.layer.borderWidth = 1
            cell2.mainView.layer.cornerRadius = 10
                //cell.mainView.layer.borderColor =
            cell2.mainView.backgroundColor = UIColor.white
            
            cell2.tag = 2

            return cell2
        }
        //Make cell reusable witht the same identifier. Identifier given in interface
    }
    
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    //Sets the height and width for cell (Hardcoded Right now)
    //Commented code is logic to implement
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//        let screenSize: CGRect = UIScreen.main.bounds
//        let height = (screenSize.height) * 0.125
        
        return CGSize(width: 270, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "ProfilePage", bundle: nil)

        
        let vcAdd = storyboard.instantiateViewController(withIdentifier: "AllSocialsPageController") as! AllSocialsPageController
        
        
        if collectionView.cellForItem(at: indexPath)?.tag == 2{
            present(vcAdd, animated: true)
        } else if(collectionView.cellForItem(at: indexPath)?.tag == 1){
            
            
            segueCurrentUsername = socialsDataSource[indexPath.row].username
            indexSocial = indexPath.row
            

            // if collectionView.cellForItem(at: indexPath).tag
            performSegue(withIdentifier: "EditSocialMediaSegue", sender: self)
        }
        
        
        

        //Present view controller with edit screen for

    }
    
    func getAllSocials(){
        do{
            socialsDataSource = try context.fetch(Social.fetchRequest())
        }catch{
            print("error")
        }
    }
    
    
    @objc func loadList(notification: NSNotification){
        //load data here
        self.collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "EditSocialMediaSegue" {
             guard let vc = segue.destination as? EditUsernameController else { return }
             vc.currentUsername = segueCurrentUsername
             vc.SocialsDataSource = socialsDataSource
             vc.index = indexSocial
             present(vc, animated: true)
         }
     }
    


}



