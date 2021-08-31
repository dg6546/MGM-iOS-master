//
//  Webservice.swift
//  MGM
//
//  Created by user-1 on 16/6/2021.
//

import Foundation
import FirebaseAuth

struct CreateProfileRequestBody:Codable{
    let firstName: String
    let lastName: String
    let email: String
    let referralCode: String
}

struct ProfileRequestBody: Codable{
    let email: String
}

struct LoginResponse: Codable {
    var statusCode: String?
    var message: String?
    var loginProfile: Profile?
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case message
        case loginProfile
    }
}


class Webservice: ObservableObject {
    
    static let URLPROTOCOL = "http://"
    static let BASEURL = "10.151.129.11:8080"
    static let GETPROFILEURL = URLPROTOCOL + BASEURL + "/tandem/mgm/login"
    static let CREATEPROFILEURL = URLPROTOCOL + BASEURL + "/tandem/mgm/signup"
    let auth = Auth.auth()
    private var app = AppSettings.shared
    
    func getProfile(email:String, completion: @escaping (Result<Profile, CustomError>) -> Void) {
        
        guard let url = URL(string: Webservice.GETPROFILEURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(app.token)", forHTTPHeaderField: "Authorization")
        let body = ProfileRequestBody(email: email)
        request.httpBody = try? JSONEncoder().encode(body)
        let requestString = String(data: request.httpBody!, encoding: .utf8)!
        print("Webservice Get Profile request:\(requestString)")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data{
                if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                    print("Webservice Get Profile response:\(JSONString)")
                }
                if let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data){
                    if let statusCode = loginResponse.statusCode, let message = loginResponse.message{
                        if statusCode == "SUCCESS"{
                            let profile = loginResponse.loginProfile
                            let dateFor: DateFormatter = DateFormatter()
                            dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            let str = profile!.rewardsPointsExpiryDateRaw.components(separatedBy: ".")[0]
                            profile!.rewardsPointsExpiryDate = dateFor.date(from: str)
                                as NSDate? ?? NSDate(timeIntervalSince1970: 0)
                            completion(.success(profile!))
                        }else{
                            return completion(.failure(.custom(errorMessage: message)))
                            
                        }
                        
                    }else { return completion(.failure(.jsonSeperation)) }
                    
                }else { return completion(.failure(.decodingError)) }
                
            } else { return completion(.failure(.noData)) }
        }.resume()
    }
    
    func createProfile(firstName: String, lastName:String, email:String, referralCode: String, completion: @escaping (Result<String, CustomError>) -> Void){
        guard let url = URL(string: Webservice.CREATEPROFILEURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let body = CreateProfileRequestBody(firstName: firstName, lastName: lastName, email: email, referralCode: referralCode)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(app.token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(body)
        let requestString = String(data: request.httpBody!, encoding: .utf8)!
        print("Create Profile request: \(requestString)")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data{
                if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                    print("Create Profile response:\(JSONString)")
                }
                if let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data){
                    if let statusCode = loginResponse.statusCode, let message = loginResponse.message{
                        
                        if statusCode == "SUCCESS"{
                            completion(.success(message))
                            return
                        }else {
                            completion(.failure(.custom(errorMessage: message)))
                            return
                        }
                        
                    }else { return completion(.failure(.jsonSeperation)) }
                    
                }else { return completion(.failure(.decodingError)) }
                
            }else { return completion(.failure(.noData)) }
        }.resume()
        
    }
    
    
}
