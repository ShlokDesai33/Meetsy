//
//  UDM.swift
//  Meetsy
//
//  Created by Shlok Desai on 15/08/22.
//

import Foundation

//
//  UDM stands for UseDefaults Manager
//  UDM is used to store key-value pairs
//

class UDM {
    
    // instance of the UDM class that is shared throughout the app
    static let shared = UDM()
    
    // only needs to be accessed inside the UDM class
    private let defaults = UserDefaults(suiteName: "com.Link.saved.data")
    
    
    func setLoggedInStatus(status: Bool) {
        UDM.shared.defaults?.set(status, forKey: "isLoggedIn")
    }
    
    func getLoggedInStatus() -> Bool {
        // logged in status will alwasy be a bool
        if let value = UDM.shared.defaults?.value(forKey: "isLoggedIn") as? Bool {
            return value
        } else {
            // default value
            return false
        }
    }
    
    
    func setName(name: String) {
        UDM.shared.defaults?.set(name, forKey: "name")
    }
    
    func getName() -> String {
        // name is always going to be string
        if let value = UDM.shared.defaults?.value(forKey: "name") as? String {
            return value
        } else {
            // default value
            return "User's Name"
        }
    }
    
    
    func setNoLinks(noOfLinks: Int) {
        UDM.shared.defaults?.set(noOfLinks, forKey: "noOfLinks")
    }
    
    func getNoLinks() -> Int {
        // no of links is always going to be an integer
        if let value = UDM.shared.defaults?.value(forKey: "noOfLinks") as? Int {
            return value
        } else {
            // default value
            return 0
        }
    }
    

    func setUserId(userId: String) {
        UDM.shared.defaults?.set(userId, forKey: "userId")
    }
    
    func getUserId() -> String {
        // _id is always going to be a ObjectId obj
        if let value = UDM.shared.defaults?.value(forKey: "userId") as? String {
            return value
        } else {
            // default value
            return ""
        }
    }
    
    // boundary is the number of links your second (or first if user only has
    // one link) top link has.
    func setTopLinks(links: [Int]) {
        UDM.shared.defaults?.set(links, forKey: "boundary")
        
    }
    
    
    //
    //  Note: do NOT alter this code (for testing only)
    //
    
    func resetKey(key: String) {
        UDM.shared.defaults?.removeObject(forKey: key)
    }
    
}
