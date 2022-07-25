//
//  ResultPageViewController.swift
//  FlagApp
//
//  Created by Ahmet Can Topcu on 20.07.2022.
//

import UIKit

class ResultPageViewController: UIViewController {

    @IBOutlet weak var labelTrue: UILabel!
    @IBOutlet weak var labelFalse: UILabel!
    
    @IBOutlet weak var labelSuccess: UILabel!
    
    var trueNumber:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        if let trueNo = trueNumber{
            labelTrue.text = "TRUE:\(trueNo)"
            labelFalse.text = "FALSE:\(5-trueNo)"
            labelSuccess.text = "%\((trueNo*100)/5) SUCCESS"
        }

    }

    @IBAction func tryAgain(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
