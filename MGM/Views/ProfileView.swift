//
//  ContentView.swift
//  MGM
//
//  Created by user-1 on 8/6/2021.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject private var app = AppSettings.shared
    @ObservedObject var profileVM = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                    Spacer()
                    VStack{Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50,
                               alignment: .center)
                        HStack{
                            Text("\(profileVM.profile.firstName)")
                                .bold()
                            Text("\(profileVM.profile.lastName)")
                                .bold()
                        }.font(.largeTitle)
                        Text("\(profileVM.profile.email)")
                            .bold()
                            .padding(.bottom)
                        Text("Current event: \(profileVM.profile.activityName)")
                        Text("Referral Code: \(app.profile.referralCode)")}
                    Spacer()
                }
                .padding()
                //.border(Color.blue, width: 5)
                .background(Color.blue)
                .cornerRadius(20.0)
                Button("Copy referral code"){
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = app.profile.referralCode
                }
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20.0)
                    .padding(.bottom)
                
                Spacer()
                
                Text("Rewards: \(profileVM.profile.rewards)")
                Text("Valid until: \(profileVM.profile.rewardsPointsExpiryDate)")
                    .padding(.bottom)
                
                Text("Refer rewards quota left: \(profileVM.profile.quota)")
                
                
                List{
                    Section(header: Text("Referee:")
                                .font(.headline)){
                        ForEach(profileVM.profile.refereeList){ referee in
                            Text("\(referee)")
                        }
                    }.textCase(nil)
                }
            }
            .navigationBarTitle(Text("Profile"))
            .toolbar(content: {
                Button("Logout"){ profileVM.logout() }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15.0)
            })
        }.onAppear()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
        }
    }
}

extension String: Identifiable{
    public var id:String {
        self
    }
}
