//
//  MenuViewController.swift
//  PlantAsgn
//
//  Created by Sandi on 11/16/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit
import LGSideMenuController

class MenuViewController: UIViewController {
    @IBOutlet weak var viewShowDetail: UIView!
    
    @IBOutlet weak var viewHome: UIView!
    
    let mainViewController = ViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       viewHome.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickViewHome)))
       viewHome.isUserInteractionEnabled = true
        
        viewShowDetail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickViewDetail)))
        viewShowDetail.isUserInteractionEnabled = true
    }
    
    @objc func onClickViewDetail() {

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
           let viewController = storyBoard.instantiateViewController(withIdentifier: "FavouriteViewController") as! FavouriteViewController

           let navigationController = sideMenuController!.rootViewController as! UINavigationController
           navigationController.pushViewController(viewController, animated: true)

           sideMenuController?.hideLeftView(animated: true, completionHandler: nil)
    }
    
    @objc func onClickViewHome() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController

        let navigationController = sideMenuController!.rootViewController as! UINavigationController
        navigationController.pushViewController(viewController, animated: true)

        sideMenuController?.hideLeftView(animated: true, completionHandler: nil)
    }


}
