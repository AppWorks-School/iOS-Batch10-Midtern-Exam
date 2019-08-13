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
    
    let kkboxProvider = KKboxProvider()
    
    var playList: PlayList?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        kkboxProvider.signIn(completion: { [weak self] result in
            
            switch result{
                
            case .success(_):
                
                self?.kkboxProvider.fetchNewHitsPlaylist("DZrC8m29ciOFY2JAm3", completion: { [weak self] result in
                    
                    switch result{
                        
                    case .success(let playList):
                        
                        self?.playList = playList
                        
                        DispatchQueue.main.async {
                            
                            self?.playListView.tableView.reloadData()
                        }
                        
                    case .failure(_):
                        break
                    }
                })
                
            case .failure(_):
                break
            }
        })
        
    }
}

extension PlayListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playList?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayListTableViewCell.identifier, for: indexPath)
        
        guard let playListCell = cell as? PlayListTableViewCell,
              let playList = self.playList
        else {
            
            return cell
        }
        
        let track = playList.data[indexPath.row]
        
        playListCell.layoutCell(
            albumImg: track.album.images[0].url,
            albumTitle: track.name,
            isLiked: true
        )
        
        return playListCell
    }
}

extension PlayListViewController: UITableViewDelegate {
    
}
