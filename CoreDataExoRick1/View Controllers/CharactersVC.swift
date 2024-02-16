//
//  CharactersVC.swift
//  CoreDataExoRick1
//
//  Created by roman domasik on 06/02/2024.
//

import UIKit
import Alamofire

class CharactersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var charList = [Results]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CharCell", bundle: nil), forCellReuseIdentifier: "CharCell")
        loadChar()
    
    }
    
    func loadChar(){
        let apiUrl = "https://rickandmortyapi.com/api/character"
        AF.request(apiUrl).response { response in
            switch response.result{
            case .success(let data):
                guard let data else {return}
                let decoder = JSONDecoder()
                do{
                    let charResponse = try decoder.decode(RickMorty.self, from: data)
                    print("json ok")
                    self.charList = charResponse.results
                } catch {
                    print("cannot parse json")
                }
            case .failure(let error):
                print("error : \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "CharCell", for: indexPath) as! CharCell
        let char = charList[indexPath.row]
        customCell.setup(char: char)
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = charList[indexPath.row]
        if let details = storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailsVC{
            details.rickAPasser = selectedCharacter
            navigationController?.pushViewController(details, animated: true)
        }
    }
    
    
    

   

}
