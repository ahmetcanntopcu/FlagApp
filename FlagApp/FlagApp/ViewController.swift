//
//  ViewController.swift
//  FlagApp
//
//  Created by Ahmet Can Topcu on 20.07.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        copyDatabase()
    }
    
    func copyDatabase(){
            let bundlePath = Bundle.main.path(forResource: "bayrakquiz", ofType: ".sqlite")
            let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let fileManager = FileManager.default
            let copyArea = URL(fileURLWithPath: targetPath).appendingPathComponent("bayrakquiz.sqlite")
            
            if fileManager.fileExists(atPath: copyArea.path){
                print("Database is already exist.")
            }else{
                do {
                    try fileManager.copyItem(atPath: bundlePath!, toPath: copyArea.path)
                } catch {
                    print(error)
                }
            }
        }


}

