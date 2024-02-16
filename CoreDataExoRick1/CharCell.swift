//
//  CharCell.swift
//  CoreDataExoRick1
//
//  Created by roman domasik on 09/02/2024.
//

import UIKit
import AlamofireImage

class CharCell: UITableViewCell {
    
    @IBOutlet var imgChar: UIImageView!
    @IBOutlet var nameChar: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setup(char: Results){
        if let imageChar = URL(string: char.image){
            imgChar.af.setImage(withURL: imageChar)
        } else {
            print("error loading the imaghe of the character")
        }
        nameChar.text = char.name
        
    }
}
