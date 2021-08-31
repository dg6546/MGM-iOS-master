//
//  CreateProfileViewModel.swift
//  MGM
//
//  Created by user-1 on 22/6/2021.
//

import Foundation
import FirebaseAuth

class CreateProfileViewModel: ObservableObject{
    private var app = AppSettings.shared
    @Published var message: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var referralCode: String = ""
    @Published var isLoading: Bool = false
    @Published var firstTimeLoading: Bool = true
    
    
    func getProfile(){
        self.isLoading = false
        guard let user = Auth.auth().currentUser else { return }
        Webservice().getProfile(email: user.email!) { [weak self] result in
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self?.app.profile = profile
                    self?.app.gotProfile = true
                    //self?.isLoading = false
                    self?.firstTimeLoading = false
                    return 
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    if !self!.firstTimeLoading{
                        self!.message = error.localizedDescription
                    }
                    self?.firstTimeLoading = false
                    //self?.isLoading = false
                    print(error)
                    return
                }
                break
            }
        }
    }
    
    func createProfile(){
        self.isLoading = false
        guard let user = Auth.auth().currentUser else { return }
        Webservice().createProfile(firstName: firstName, lastName: lastName, email: user.email!, referralCode: referralCode ) { [weak self] result in

            
            switch result {
            case .success(let string):
                DispatchQueue.main.async {
                    self?.message = string
                    self?.getProfile()
                    //self?.isLoading = false
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.message = error.localizedDescription
                    print(error)
                    //self?.isLoading = false
                }
                break
            }
        }
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
