//
//  ViewController.swift
//  Medium-Playground
//
//  Created by WU CHIH WEI on 2019/8/12.
//  Copyright © 2019 WU CHIH WEI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let kkboxProvider = KKboxProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signIn()
    }

    func signIn() {
        
        kkboxProvider.signIn(completion: { result in
            
            switch result{
                
            case .success(let user):
                
                print(user)
                
            case .failure(let error):
                
                print(error)
            }
            
        })
        
    }
    
    func fetchHitsPlayList() {
        
    }

}

