//
//  ClientManager.swift
//  Fractal
//
//  Created by Pedro Cortez on 11/6/20.
//  Copyright © 2020 gamestorming. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftyJSON

class ClientManager: NSObject {
//    static let sharedInstance = ClientManager()
    static let initialClients = 40
    static let moreClients = 20
    
    private lazy var clientRef: DatabaseReference = Database.database().reference().child("Cliente")
    
    func requestInitialClients(responseHandler: @escaping (_ error: Bool, _ messages: [Client]?) -> ()){
        let query = self.clientRef.queryOrderedByKey().queryLimited(toLast: UInt(ClientManager.initialClients))
        
        query.observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            if let values = snapshot.value as? Dictionary<String, AnyObject>{
                var clients = [Client]()
                
                for (key, value) in values {
                        let clientId = key
                        if let clientDict = value as? Dictionary<String, AnyObject>{
                            let json = JSON(clientDict)
                            let user = Client(cliId: clientId, json: json)
                            clients.append(user)
//                            if endMessage.id != message.id{
//                                messages.append(message)
//                            }
                        }
                    }
                responseHandler(true, clients)
            }
          // ...
          }) { (error) in
            responseHandler(false, nil)
            print(error.localizedDescription)
        }
    }
    
    func requestMoreClients(client: Client, responseHandler: @escaping (_ error: Bool, _ messages: [Client]?) -> ()){
        let query = self.clientRef.queryOrderedByKey().queryEnding(atValue: client.id).queryLimited(toLast: UInt(ClientManager.moreClients))
            
            query.observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
                if let values = snapshot.value as? Dictionary<String, AnyObject>{
                    var clients = [Client]()
                    
                    for (key, value) in values {
                            let clientId = key
                            if let clientDict = value as? Dictionary<String, AnyObject>{
                                let json = JSON(clientDict)
                                let user = Client(cliId: clientId, json: json)
                                clients.append(user)
    //                            if endMessage.id != message.id{
    //                                messages.append(message)
    //                            }
                            }
                        }
                    responseHandler(true, clients)
                }
              

              // ...
              }) { (error) in
                responseHandler(false, nil)
                print(error.localizedDescription)
            }
        }
    
    func requestInitialClientsWithWord(name: String, responseHandler: @escaping (_ error: Bool, _ messages: [Client]?) -> ()){
        let query = self.clientRef.queryOrderedByKey().queryLimited(toLast: UInt(ClientManager.initialClients)).
            
            query.observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
                if let values = snapshot.value as? Dictionary<String, AnyObject>{
                    var clients = [Client]()
                    
                    for (key, value) in values {
                            let clientId = key
                            if let clientDict = value as? Dictionary<String, AnyObject>{
                                let json = JSON(clientDict)
                                let user = Client(cliId: clientId, json: json)
                                clients.append(user)
    //                            if endMessage.id != message.id{
    //                                messages.append(message)
    //                            }
                            }
                        }
                    responseHandler(true, clients)
                }
              // ...
              }) { (error) in
                responseHandler(false, nil)
                print(error.localizedDescription)
            }
        }
    
    func createChat() -> String{
        let client = self.clientRef.childByAutoId()
        return client.key ?? ""
    }
    
    func addClient(client: Client){
        let clientRef = self.clientRef.child(createChat())
        
        let values = [
            "firstName": client.firstName,
            "lastName": client.lastName,
            "phone": client.phone,
            "email": client.email,
            ] as [String : Any]
        
        clientRef.updateChildValues(values)
    }
    
    func updateClient(client: Client){
        let clientRef = self.clientRef.child(client.id)
        
        let values = [
            "firstName": client.firstName,
            "lastName": client.lastName,
            "phone": client.phone,
            "email": client.email,
            ] as [String : Any]
        
        clientRef.updateChildValues(values)
    }
}
