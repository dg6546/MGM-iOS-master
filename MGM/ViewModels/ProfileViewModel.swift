//
//  ProfileViewModel.swift
//  MGM
//
//  Created by user-1 on 17/6/2021.
//

import Foundation
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    @Published var profile: Profile
    private var app = AppSettings.shared
    
    init() {
        self.profile = app.profile
    }
    
    
    func logout(){
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
        } catch let signOutError as NSError{
            print ("Error signing out: %@", signOutError)
        }
        app.profile = Profile()
        app.isAuthenticated = false
        app.gotProfile = false
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "jsonwebtoken")
    }
    
}
