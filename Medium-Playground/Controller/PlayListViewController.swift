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
    
    var playList: PlayList?
    
    var isFetchNextPage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signIn(completion: { [weak self] in
            
            self?.fetchPlayList(offset: 0)
        })
    }
    
    //MARK: - Action
    
    func signIn(completion: @escaping () -> Void) {
        
        KKboxAuthManager.signIn { result in
            
            switch result{
                
            case .success:
                
                completion()
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    func fetchPlayList() {
        
        guard let offset = playList?.paging.offset else { return }
        
        fetchPlayList(offset: offset + 20)
    }
    
    func fetchPlayList(offset: Int) {
        
        KKboxProvider.fetchNewHitsPlaylist(
            "DZrC8m29ciOFY2JAm3",
            offset: String(offset),
            completion: { [weak self] result in
                
                switch result{
                    
                case .success(let playList):
                    
                    guard let list = playList.data,
                          list.count > 0
                    else {
                        
                        self?.playList?.paging.offset = nil
                        
                        return
                    }
                    
                    if self?.playList == nil {
                        
                        self?.playList = playList
                    
                    } else {
                        
                        self?.playList?.data?.append(contentsOf: playList.data!)
                        
                        self?.playList?.paging.offset = playList.paging.offset
                    }
                    
                    self?.playListView.tableView.reloadData()
                    
                    self?.isFetchNextPage = false
                    
                case .failure(let error):
                    
                    print(error)
                }
            }
        )
    }
}

extension PlayListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playList?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayListTableViewCell.identifier, for: indexPath)
        
        guard let playListCell = cell as? PlayListTableViewCell,
              let playList = self.playList,
              let track = playList.data?[indexPath.row]
        else {
            
            return cell
        }
        
        playListCell.layoutCell(
            albumImg: track.album.images[0].url,
            albumTitle: track.name,
            isLiked: true
        )
        
        return playListCell
    }
}

extension PlayListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut, animations: {
            
            cell.alpha = 1
        })
        
        animator.startAnimation()
        
        if (indexPath.row > playList!.data!.count - 5) && !isFetchNextPage {
            
            isFetchNextPage = true
            
            print("fetch next page", playList!.paging.offset!)
            
            fetchPlayList()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(scrollView.bounds.origin.y)
        
        if (scrollView.bounds.origin.y < 0) && (scrollView.bounds.origin.y >= -UIScreen.main.bounds.width) {
            
            playListView.updateHeaderViewLayout(
                y: -(scrollView.bounds.origin.y + UIScreen.main.bounds.width) / 4,
                alpha: 1 + scrollView.bounds.origin.y / UIScreen.main.bounds.width)
        }
        
        if scrollView.bounds.origin.y < -UIScreen.main.bounds.width {
            
            playListView.updateHeaderViewLayout(y: 0, alpha: 0, width: -scrollView.bounds.origin.y)
        }
        
        if scrollView.bounds.origin.y > 0 {
            
            playListView.headerImgView.alpha = 0.0
            
            playListView.blurView.alpha = 0.0
        }
    }
}
