//
//  ViewController.swift
//  CodePathProject
//
//  Created by Christopher Yoeurng on 8/31/25.
//

import UIKit

class ViewController: UIViewController {
    var wantBlue = true;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func wantBlue(_ sender: UISwitch) {
        wantBlue = !wantBlue
    }
    @IBAction func changeBackgroundColor(_ sender: UIButton) {
        let randomColor = changeColor()
        view.backgroundColor = randomColor

    }
    func changeColor() -> UIColor{

        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = wantBlue ? CGFloat.random(in: 0...1): 0

        return UIColor(red: red, green: green, blue: blue, alpha: 0.5)
    }

}

