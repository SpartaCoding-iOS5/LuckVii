//
//  ViewController.swift
//  LuckVii
//
//  Created by 손겸 on 12/16/24.
//

import UIKit

class ViewController: UIViewController {

    let paymentResultView = PaymentResultView()
    override func loadView() {
        self.view = paymentResultView
    }
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
