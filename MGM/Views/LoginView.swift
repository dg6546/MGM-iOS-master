//
//  ContentView.swift
//  MGM
//
//  Created by user-1 on 8/6/2021.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var app = AppSettings.shared
    @ObservedObject var loginVM = LoginViewModel()
    
    var body: some View {
        
        ZStack{
            NavigationView {
                VStack{
                    Text("Welcome back!")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.bottom)
                    TextField("E-mail",
                              text: $loginVM.email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    SecureField("Password",
                                text: $loginVM.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    HStack{
                        Spacer()
                        Button("Login") {
                            guard !loginVM.email.isEmpty, !loginVM.password.isEmpty else{
                                loginVM.message = "Please enter email and password"
                                return
                            }
                            loginVM.firebaseLogin()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15.0)
                        Spacer()
                    }
                    Text("\(loginVM.message)")
                        .foregroundColor(.red)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    NavigationLink(destination: RegisterView()) {
                        Text("Don't have an account yet? Click here to register")
                    }
                }
            }
            .padding()
            if loginVM.isLoading{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(3)
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

