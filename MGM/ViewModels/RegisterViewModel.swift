//
//  ProfileViewModel.swift
//  MGM
//
//  Created by user-1 on 17/6/2021.
//

import Foundation
import FirebaseAuth

class RegisterViewModel: ObservableObject {
    @Published var profile: Profile
    @Published var email: String = ""
    @Published var message: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    private var app = AppSettings.shared
    let auth = Auth.auth()
    
    init() {
        self.profile = app.profile
    }
    
    func firebaseRegister(){
        auth.createUser(withEmail: email, password: password){ [weak self] result, error in
            guard result != nil, error == nil else {
                self?.message = error!.localizedDescription
                print(error!.localizedDescription)
                return
            }
            let currentUser = Auth.auth().currentUser
            currentUser?.getIDTokenForcingRefresh(true) { token, error in
                if let error = error{
                    self?.message = error.localizedDescription
                    print(error.localizedDescription)
                    return
                }
                DispatchQueue.main.async {
                    self!.app.isAuthenticated = true
                    self!.app.token = token!
                    print(token!)
                    return
                }
            }
        }
    }
    

    
}
