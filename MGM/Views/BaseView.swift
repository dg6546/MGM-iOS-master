//
//  BaseView.swift
//  MGM
//
//  Created by user-1 on 18/6/2021.
//

import SwiftUI

struct BaseView: View {
    @ObservedObject private var app = AppSettings.shared
    var body: some View {
        Group{
            if app.isAuthenticated && app.gotProfile{
                ProfileView()
            }else if app.isAuthenticated && !app.gotProfile {
                CreateProfileView()
            }else{
                LoginView()
            }
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
