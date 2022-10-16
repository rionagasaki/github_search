
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.


import UIKit
import RxSwift

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var stargazersCountLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var openIssueCountLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    var searchItem:SearchItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageLabel.text = "Written in \(searchItem.language ?? "")"
        stargazersCountLabel.text = "\(searchItem.stargazersCount ?? 0) stars"
        watchersCountLabel.text = "\(searchItem.watchersCount ?? 0) watchers"
        forksCountLabel.text = "\(searchItem.forksCount ?? 0) forks"
        openIssueCountLabel.text = "\(searchItem.openIssuesCount ?? 0) open issues"
        getImage()
    }
    
    private func getImage(){
        userFullNameLabel.text = searchItem.fullName ?? ""
        if let owner = searchItem.owner{
            if let avatarImageUrl = owner.avatarUrl {
                guard let imageRequest = URL(string: avatarImageUrl) else { return }
                URLSession.shared.rx.response(request: URLRequest(url: imageRequest)).subscribe(onNext: { response, data in
                    let httpResponse = response as HTTPURLResponse
                    if httpResponse.statusCode != 200 { return }
                    let avatarImage = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.avatarImageView.image = avatarImage
                    }
                }, onError: { error in
                    print("ERROR\(error)")
                }).disposed(by: disposeBag)
            }
        }
    }
}
