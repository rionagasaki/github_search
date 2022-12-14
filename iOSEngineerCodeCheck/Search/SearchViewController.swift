//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var apiSearchView: UISearchBar!
    
    private let disposeBag = DisposeBag()
    private var searchState:SearchState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emptyLabel)
        apiSearchView.placeholder = "検索する"
        apiSearchView.delegate = self
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emptyLabel.frame = CGRect(x: (view.frame.width/2)-(emptyLabel.intrinsicContentSize.width/2), y: 250, width: emptyLabel.intrinsicContentSize.width, height: emptyLabel.intrinsicContentSize.height)
    }
    
    private func bind(){
        appStore.searchState.drive(onNext:{ [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.handle($0)
        }).disposed(by: disposeBag)
        
        // インクリメンタルサーチを行う。
        apiSearchView.rx.text.orEmpty.distinctUntilChanged().subscribe(onNext:{ searchWord in
            SearchActionCreater.searchButtonClicked(word: searchWord)
        }).disposed(by: disposeBag)
    }
    
    // ReducerによってStateが更新されると呼ばれる。
    private func handle(_ state:SearchState){
        self.searchState = state
        self.searchState?.search_results.count == 0 ? (emptyLabel.isHidden = false):(emptyLabel.isHidden = true)
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        SearchActionCreater.searchButtonClicked(word: searchText)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchState?.search_results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let searchResult = searchState?.search_results[indexPath.row]
        cell.textLabel?.text = searchResult?.fullName ?? ""
        cell.detailTextLabel?.text = searchResult?.language ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let searchResultViewController = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! SearchResultViewController
                searchResultViewController.searchItem = searchState?.search_results[indexPath.row]
                self.present(searchResultViewController, animated: true, completion: nil)
    }
    
    private let emptyLabel:UILabel = {
        let label = UILabel()
        let emptyText = NSMutableAttributedString()
        if let image = UIImage(systemName:"magnifyingglass") {
            let attachment = NSTextAttachment()
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 20)
            emptyText.append(NSAttributedString(attachment: attachment))
        }
        emptyText.append(NSAttributedString(string: "検索バーより検索してください"))
                      
        label.attributedText = emptyText
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
}
