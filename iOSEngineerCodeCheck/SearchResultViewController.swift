
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.


import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var TtlLbl: UILabel!
    
    @IBOutlet weak var LangLbl: UILabel!
    
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
    var repo:SearchItem!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        LangLbl.text = "Written in \(repo.language ?? "")"
        StrsLbl.text = "\(repo.stargazersCount ?? 0) stars"
        WchsLbl.text = "\(repo.watchersCount ?? 0) watchers"
        FrksLbl.text = "\(repo.forksCount ?? 0) forks"
        IsssLbl.text = "\(repo.openIssuesCount ?? 0) open issues"
        getImage()
    }
    
    func getImage(){
        TtlLbl.text = repo.fullName ?? ""
        
        if let owner = repo.owner{
            if let imgURL = owner.avatarUrl {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.ImageView.image = img
                    }
                }.resume()
            }
        }
    }
}
