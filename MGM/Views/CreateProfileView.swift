//
//  SwiftUIView.swift
//  MGM
//
//  Created by user-1 on 22/6/2021.
//

import SwiftUI

struct CreateProfileView: View {
    @ObservedObject var cpVM = CreateProfileViewModel()
    var body: some View {
        ZStack{
            if cpVM.isLoading{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(3)
            }else{
                VStack{
                    Text("Tell us more about you 😁")
                        .padding()
                    HStack{
                        TextField("First name",
                                  text: $cpVM.firstName)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        TextField("Last Name",
                                  text: $cpVM.lastName)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(5.0)
                            .padding(.bottom, 20)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    TextField("Referral code",
                              text: $cpVM.referralCode)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Text("\(cpVM.message)")
                        .foregroundColor(.red)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    HStack{
                        Spacer()
                        Button("Submit") {
                            guard !cpVM.firstName.isEmpty, !cpVM.lastName.isEmpty else{
                                cpVM.message = "Please enter email and password"
                                return
                            }
                            cpVM.createProfile()
                        }
                        Spacer()
                        Button("Logout") {
                           cpVM.logout()
                        }
                    }
                }
                .onAppear(perform: cpVM.getProfile)
                .padding()
            }
        }
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView()
    }
}
