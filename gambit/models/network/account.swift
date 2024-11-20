//
//  accountModel.swift
//  node
//
//  Created by Nick Mantini on 10/28/24.
//

import Foundation
import Request
import Json

@MainActor
class Account: ObservableObject {
    @Published var account: AccountModel = AccountModel()
    
    var isLoggedIn: Bool {
        return self.account._id != ""
    }
    
    @MainActor
    func appleAuthenticationLogin(appleId: String, authToken: String="", fullName: String="", email: String="", completion: @escaping ((code: String, message: String)?) -> Void) {
        Request {
            Url(serverIp+"/appleAuth")
            Method(.post)
            Header.Accept(.json)
            Query(["authToken": authToken, "appleId": appleId, "fullName": fullName, "email": email])
        }
        .onData { data in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedAccount = try decoder.decode(AccountModel.self, from: data)
                DispatchQueue.main.async {
                    self.account = decodedAccount
                    completion(nil)
                }
            } catch {
                print("Decoding error:", error)
                DispatchQueue.main.async {
                    completion(("DECODE_ERROR", "Network error, Try again later."))
                }
            }
        }
        .onError { error in
            if let requestError = error as? RequestError {
                let (errorCode, errorMsg) = getRequestError(requestError)
                completion((errorCode, errorMsg))
            }
            else {
                completion(("UNKOWN", "Network error, Try again later."))
            }
        }
        .call()
    }
    
    @MainActor
    func phoneAuthenticaionLogin(
        phoneNumber: String,
        password: String,
        username: String = "",
        completion: @escaping ((code: String, message: String)?) -> Void
    ) {
        let parameters = [
            "phoneNumber": phoneNumber,
            "password": password,
            "username": username,
        ]

        Request {
            Url(serverIp + "/phoneAuth")
            Method(.post)
            Header.Accept(.json)
            Header.ContentType(.json)
            Body(parameters)
        }
        .onData { data in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let decodedAccount = try decoder.decode(AccountModel.self, from: data)
                DispatchQueue.main.async {
                    self.account = decodedAccount
                    completion(nil)
                }
            } catch {
                print("Decoding error:", error)
                DispatchQueue.main.async {
                    completion(("DECODE_ERROR", "Network error, Try again later."))
                }
            }
        }
        .onError { error in
            if let requestError = error as? RequestError {
                let (errorCode, errorMsg) = getRequestError(requestError)
                completion((errorCode, errorMsg))
            }
            else {
                completion(("UNKOWN", "Network error, Try again later."))
            }
        }
        .call()
    }

    @MainActor
    func updateUser() {
        let url = URL(string: serverIp+"/updateUser")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(self.account)
            request.httpBody = jsonData
            
            Task {
                let (_, _) = try await URLSession.shared.data(for: request)
            }
        } catch {
            print(error)
        }
    }
}
