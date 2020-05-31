//
//  RankingDateViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/17.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit

class RankingDateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var nameAndScore: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
               
        nameAndScore.removeAll()
               
        if let savedname = UserDefaults.standard.array(forKey: "nameAndScore") as? [[String]] {
            nameAndScore = savedname
            print(nameAndScore)
        }
        tableView.reloadData()
    }
}

extension RankingDateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameAndScore.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
        let ranking = nameAndScore[indexPath.row]
        cell?.textLabel?.text = "\(indexPath.row + 1) \(ranking) "
      
        return cell ?? UITableViewCell()
    }
}
