//
//  ListViewController.swift
//  Fractal
//
//  Created by Pedro Cortez on 11/6/20.
//  Copyright © 2020 gamestorming. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchName: UITextField!
    let UpdateClientSegue = "UpdateClientSegue"
    let ClientCellIdentifier = "ClientCellIdentifier"
    var clients = [Client]()
    var clientManager = ClientManager()
    var currentClient = Client()
    var isSearch = false
    var name = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clients.removeAll()
        self.clientManager.requestInitialClients(responseHandler: { (haveUser, clients) in
            if haveUser {
                self.clients = clients!
                self.tableView.reloadData()
            }
        })
    }
    
    func loadMoreClients(){
        
        let client = self.clients[0]
        if isSearch{
            self.clientManager.requestMoreClientsWithWord(name: self.name, client: client) { (haveUser, clients) in
            if haveUser {
                self.showMoreClients(moreClients: clients ?? [Client]())
                }
            
            }
        }else{
            self.clientManager.requestMoreClients(client: client) { (haveUser, clients) in
            if haveUser {
                self.showMoreClients(moreClients: clients ?? [Client]())
                }
            
            }
        }
    }
    
    func showMoreClients(moreClients: [Client]){
        self.clients.insert(contentsOf: moreClients, at: 0)
        
        var indexPaths = [IndexPath]()
        var index = 0
        for _ in moreClients{
            let indexPath = IndexPath(row: index, section: 0)
            indexPaths.append(indexPath)
            index += 1
        }
        
        var contentOffest = self.tableView.contentOffset
        self.tableView.isScrollEnabled = false
        self.tableView.reloadData()
        self.tableView.layoutIfNeeded()
        
        if let indexPath = indexPaths.last{
            let rect = self.tableView.rectForRow(at: indexPath)
            contentOffest.y += rect.maxY
            self.tableView.setContentOffset(contentOffest, animated: false)
        }
        
        self.tableView.isScrollEnabled = true
    }
    
    @IBAction func search(_ sender: UIButton){
        self.name = self.searchName.text ?? ""
        self.isSearch = true
        self.restartSearch()
    }
    
    func restartSearch(){
        self.clients.removeAll()
        self.tableView.reloadData()
        self.clientManager.requestInitialClientsWithWord(name: name) { (haveUser, clients) in
            if haveUser {
                self.clients = clients!
                self.tableView.reloadData()
            }
        }
    }
    
//     MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? AddOrUpdateViewController{
            viewController.isUpdate = true
            viewController.client = self.currentClient
            
        }
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.clients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.ClientCellIdentifier, for: indexPath) as? ClientTableViewCell else {
            return UITableViewCell()
        }
        cell.name.text = "\(indexPath.row).- \(self.clients[indexPath.row].getName())"
        cell.email.text = self.clients[indexPath.row].email
        cell.phone.text = self.clients[indexPath.row].phone
        if (indexPath.row == self.clients.count - 1) {
            self.loadMoreClients()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.currentClient = self.clients[indexPath.row]
        self.performSegue(withIdentifier: self.UpdateClientSegue, sender: nil)
    }
    
    
}
