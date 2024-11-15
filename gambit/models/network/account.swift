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
        return self.account.appleId != ""
    }
    
    @MainActor
    func authenticateUser(authToken: String, appleId: String, fullName: String, email: String) {
        Request {
            Url(serverIp+"/authUser")
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
                }
            } catch {
                print(error)
            }
        }
        .onError { error in
            
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
