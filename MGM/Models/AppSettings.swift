//
//  App.swift
//  MGM
//
//  Created by Ming Tsun Lee on 21/6/2021.
//

import Foundation

class AppSettings: ObservableObject{
    static let shared = AppSettings()
    @Published var isAuthenticated:Bool = false
    @Published var gotProfile:Bool = false
    @Published var profile = Profile()
    @Published var token:String = ""
    @Published var email: String = ""
    private init() {
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        self.token = token
        self.isAuthenticated = true
    }
}
