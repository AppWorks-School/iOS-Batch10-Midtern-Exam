//
//  PlayListViewController.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/12.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class PlayListViewController: UIViewController {

    @IBOutlet weak var playListView: PlayListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension PlayListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayListTableViewCell.identifier, for: indexPath)
        
        guard let playListCell = cell as? PlayListTableViewCell else { return }
        
        
        
        return playListCell
    }
}

extension PlayListViewController: UITableViewDelegate {
    
}
