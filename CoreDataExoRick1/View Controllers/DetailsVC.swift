//
//  DetailsVC.swift
//  CoreDataExoRick1
//
//  Created by roman domasik on 06/02/2024.
//

import UIKit
import AlamofireImage
import Alamofire

class DetailsVC: UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var charName: UILabel!
    @IBOutlet var likeBtn: UIButton!
    @IBOutlet var status: UILabel!
    @IBOutlet var genre: UILabel!
    @IBOutlet var origin: UILabel!
    @IBOutlet var listOfEpisodes: UITextView!
    
    var rickAPasser: Results?
    
    var isFavorite: Bool = false{
        didSet{
            updateButton(isFavorite: isFavorite)
            
            guard let rickId = rickAPasser?.id else { return }
            UserDefaults.standard.setValue(isFavorite, forKey: "fav_\(rickId)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pic = rickAPasser?.image{
            image.af.setImage(withURL: URL(string: pic)!)
        }
        
        if let name = rickAPasser?.name{
            charName.text = name
        }
        if let statuus = rickAPasser?.status{
            status.text = statuus.rawValue
        }
        
        if let origiin = rickAPasser?.origin{
            origin.text = origiin.name
        }
        
        if let episodes = rickAPasser?.episode{
            fetchEpisodeDetails(for: episodes)
        }
        updateButton(isFavorite: isFavorite)
    }
    
    @IBAction func pressLikeBtn(){
        isFavorite.toggle()
        guard let perso = charName.text else { return }
        
        if !isFavorite {
            DataManager.shared.deleteFavoriteWithName(name: perso)
            print("removed from favorites")
        } else {
            DataManager.shared.addFavorite(name: perso)
            print("added to favorites")
        }
        updateButton(isFavorite: isFavorite)
    }
    
    func updateButton(isFavorite: Bool){
        if isFavorite{
            likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    // Fonction pour récupérer les détails des épisodes à partir des URL
    func fetchEpisodeDetails(for episodeURLs: [String]) {
        var episodesDetails = [String]()
        let dispatchGroup = DispatchGroup()

        for episodeURL in episodeURLs {
            dispatchGroup.enter()

            if let url = URL(string: episodeURL) {
                // Requête Alamofire pour récupérer les détails de l'épisode
                AF.request(url).responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        // Si la requête réussit, traitez les détails de l'épisode
                        if let episodeDetails = value as? [String: Any],
                           let episodeName = episodeDetails["name"] as? String {
                            episodesDetails.append(episodeName)
                        }
                    case .failure(let error):
                        // Si la requête échoue, imprimez l'erreur dans la console
                        print("Erreur de requête pour \(episodeURL): \(error.localizedDescription)")
                    }

                    dispatchGroup.leave()
                }
            }
        }

        // Notification lorsque toutes les requêtes sont terminées
        dispatchGroup.notify(queue: .main) {
            // Met à jour l'interface avec les noms des épisodes
            self.listOfEpisodes.text = episodesDetails.joined(separator: ", ")
        }
    }
    

}
