//
//  ContentView.swift
//  MGM
//
//  Created by user-1 on 8/6/2021.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var rgVM = RegisterViewModel()
    var body: some View {
        VStack{
            TextField("email",
                      text: $rgVM.email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password",
                        text: $rgVM.password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Confirm Password",
                        text: $rgVM.confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5.0)
                .padding(.bottom, 20)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            Text("\(rgVM.message)")
                .foregroundColor(.red)
                .padding()
                .fixedSize(horizontal: false, vertical: true)
            HStack{
                Spacer()
                Button("Register") {
                    guard !rgVM.email.isEmpty, !rgVM.password.isEmpty else{
                        rgVM.message = "Please enter email and password"
                        return
                    }
                    
                    guard rgVM.password == rgVM.confirmPassword else{
                        rgVM.message = "Passwords don't match."
                        return
                    }
                    rgVM.firebaseRegister()
                }
                Spacer()
                    .navigationBarTitle(Text("Register"))
                
            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
