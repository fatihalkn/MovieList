//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Fatih on 25.12.2023.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailView: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailRating: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    
    var selectedMovie: Result?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitle.text = selectedMovie?.originalTitle
        detailDescription.text = selectedMovie?.overview
        detailRating.text = "\(selectedMovie!.popularity!)"
        
        if let posterPath = selectedMovie?.posterPath {
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w342/\(posterPath)"){
                URLSession.shared.dataTask(with: URLRequest(url: imageURL)) {
                    (data,req,error) in
                    
                    DispatchQueue.main.async {
                        self.detailView.image = UIImage(data: data!)
                    }
                }.resume()
            }
            
            
        }
    }
    
    
    
}



