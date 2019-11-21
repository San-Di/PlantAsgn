//
//  LoginViewController.swift
//  PlantAsgn
//
//  Created by Sandi on 11/15/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var viewEmail: CardView!
    
    @IBOutlet weak var viewPassword: CardView!
    
    @IBOutlet weak var btnLogin: UIButton!

    let bag = DisposeBag()
    private let viewModel = PlantListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewEmail.layer.cornerRadius = 25
        txtFieldEmail.borderStyle = .none
        viewEmail.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        viewPassword.layer.cornerRadius = 25
        txtFieldPassword.borderStyle = .none
        viewPassword.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        btnLogin.layer.cornerRadius = 25
        btnLogin.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }

    @IBAction func btnLogin(_ sender: Any) {
        let email = txtFieldEmail.text ?? ""
        let password = txtFieldPassword.text ?? ""
        
        viewModel.requestLogin(email: email, password: password)
        
        
        viewModel.loginUserObs.observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                data in
                print("login data !!!! \(data.user_name)")
                UserDefaults.standard.set(data.user_name, forKey: "user_name")
                
                
                guard let mainVC = self.storyboard?.instantiateViewController(identifier: String(describing: SideMenuViewController.self)) as? SideMenuViewController else {
                    fatalError("Main view controller is not found in Storyboard!")
                }
                self.navigationController?.pushViewController(mainVC, animated: true)
            }).disposed(by: bag)
    }
    
}
