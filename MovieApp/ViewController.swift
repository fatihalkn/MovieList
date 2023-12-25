//
//  ViewController.swift
//  MovieApp
//
//  Created by Fatih on 25.12.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mTable: UITableView!
    
    var dataList = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTable.backgroundColor = UIColor.lightGray
        mTable.dataSource = self
        mTable.delegate = self
      
        
        mTable.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=c7f7d1dc5a6aa58fd2f3602748ad9c64&language=en-US&page=1")!)) { (data,req,error) in
            
            do {
                let result = try JSONDecoder().decode(MovieResult.self, from: data!)
                DispatchQueue.main.async {
                    self.dataList = result.results!
                    self.mTable.reloadData()
                }
            } catch {
                print("error!")
            }
        }.resume()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.onBind(data: dataList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = dataList[indexPath.row]
         let detailViewController = DetailViewController(nibName: "DetailViewController", bundle: .main)
            detailViewController.selectedMovie = selectedMovie
                self.navigationController?.pushViewController(detailViewController, animated: true)
           
        
        mTable.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    
}

