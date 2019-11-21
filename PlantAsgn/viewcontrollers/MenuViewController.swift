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
    
    @IBOutlet weak var viewLogout: UIView!
    
    let mainViewController = ViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    viewHome.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickViewHome)))
       viewHome.isUserInteractionEnabled = true
        
    viewShowDetail.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickViewDetail)))
        
        viewShowDetail.isUserInteractionEnabled = true
        
        viewLogout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickLogout)))
        
        viewLogout.isUserInteractionEnabled = true
    }
    
    @objc func onClickLogout() {
        let alertController = UIAlertController(title: "Log Out", message:
            "Are you sure you want to Log out!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default){
            UIAlertAction in
            UserDefaults.standard.removeObject(forKey: "user_name")
            guard let loginVC = self.storyboard?.instantiateViewController(identifier: String(describing: LoginViewController.self)) as? LoginViewController else {
                               fatalError("LoginViewController is not found in Storyboard!")
            }
           self.navigationController?.pushViewController(loginVC, animated: true)
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (onCancel) in
            
        }))
        

        self.present(alertController, animated: true, completion: nil)
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
