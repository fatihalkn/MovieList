//
//  CustomCell.swift
//  MovieApp
//
//  Created by Fatih on 25.12.2023.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var mİmage: UIImageView!
    @IBOutlet weak var mTitle: UILabel!
    @IBOutlet weak var mExp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func onBind(data:Result) {
        mTitle.text = data.title
        mExp.text = data.overview
        if let posterPath = data.posterPath {
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w342/\(posterPath)"){
                URLSession.shared.dataTask(with: URLRequest(url: imageURL)) {
                    (data,req,error) in
                    
                        DispatchQueue.main.async {
                            self.mİmage.image = UIImage(data: data!)
                        }
                }.resume()
            }
            

        }
        
    }
    
}
