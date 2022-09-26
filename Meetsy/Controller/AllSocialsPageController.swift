//
//  AllSocialsPageController.swift
//  Meetsy
//
//  Created by APPLE on 13/09/22.
//

import UIKit
import CoreData

class AllSocialsPageController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //var socialsArray = [Social]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SocialMedias.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllSocialsCell") as! AllSocialsCell
        
        cell.logo.image = UIImage(named: SocialMedias.list[indexPath.row])
        
        cell.logo.tag = indexPath.row
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addUsernames(_ sender: Any) {
        
        let cells = self.tableView.visibleCells as! [AllSocialsCell]
        
        for cell in cells{
            
            if(cell.usernameTF.text != ""){
                
                let newItem = Social(context: context)
                newItem.username = cell.usernameTF.text
                newItem.platform = SocialMedias.list[cell.logo.tag]
                
                do{
                    try context.save()
                }
                catch{
                    
                }
                
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        dismiss(animated: true)
       
        
      
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
