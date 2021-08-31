//
//  ViewModel.swift
//  MGM
//
//  Created by user-1 on 10/6/2021.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    let auth = Auth.auth()
    @Published var email: String = ""
    @Published var password: String = ""
    private var app = AppSettings.shared
    @Published var message: String = ""
    @Published var isLoading: Bool = false
    
    func firebaseLogin(){
        //self.isLoading = false
        let defaults = UserDefaults.standard
        
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                self?.message = error?.localizedDescription ?? "Login failed"
                print(error?.localizedDescription)
                self?.isLoading = false
                return
            }
            let currentUser = Auth.auth().currentUser
            currentUser?.getIDTokenForcingRefresh(true) { [weak self] token, error in
                if let error = error{
                    //self?.isLoading = false
                    self?.message = error.localizedDescription
                    print(error.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    self!.app.isAuthenticated = true
                    self!.app.token = token!
                    self!.app.email = self!.email
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    //self?.isLoading=false
                    print(token!)
                    return
                    
                }
            }

        }
    }
    
    func getProfile(){
        //self.isLoading = false
        guard let user = Auth.auth().currentUser else { return }
        Webservice().getProfile(email: user.email!) { [weak self] result in
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self?.app.profile = profile
                    self?.app.gotProfile = true
                    //self?.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                    //self?.isLoading = false
                }
            }
        }
    }
}
