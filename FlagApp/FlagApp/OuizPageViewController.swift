//
//  OuizPageViewController.swift
//  FlagApp
//
//  Created by Ahmet Can Topcu on 20.07.2022.
//

import UIKit

class OuizPageViewController: UIViewController {
    @IBOutlet weak var labelTrue: UILabel!
    @IBOutlet weak var labelFalse: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    
    @IBOutlet weak var imageViewFlag: UIImageView!
    
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    
    var trueNumber = 0
    var falseNumber = 0
    var currentQuestionNumber = 0
    var totalFlagList = [Flag]()
    var wrongAnswerList = [Flag]()
    var realAnswerList = Set<Flag>()
    var realAnswerArray = [Flag]()
    var correctFlag = Flag()
    var randomNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadQuestion()

    }
    
    func loadQuestion(){
        totalFlagList = FlagDao().randomFiveQuestion()
        correctFlag = totalFlagList[generateRandomNumber()]
        wrongAnswerList = FlagDao().randomThreeAnswer(correctFlagID: correctFlag.flag_id!)
        realAnswerList.insert(correctFlag)
        realAnswerList.insert(wrongAnswerList[0])
        realAnswerList.insert(wrongAnswerList[1])
        realAnswerList.insert(wrongAnswerList[2])
        
        
        for k in realAnswerList{
            realAnswerArray.append(k)
        }
        
        labelTrue.text = "TRUE:\(trueNumber)"
        labelFalse.text = "FALSE:\(falseNumber)"
        labelQuestion.text = "QUESTION \(currentQuestionNumber+1)"
        
        imageViewFlag.image = UIImage(named: correctFlag.flag_image!)
        
        buttonA.setTitle(realAnswerArray[0].flag_name, for: .normal)
        buttonB.setTitle(realAnswerArray[1].flag_name, for: .normal)
        buttonC.setTitle(realAnswerArray[2].flag_name, for: .normal)
        buttonD.setTitle(realAnswerArray[3].flag_name, for: .normal)
        
        
        realAnswerList.removeAll()
        totalFlagList.removeAll()
        realAnswerArray.removeAll()
        wrongAnswerList.removeAll()

        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ResultPageViewController
        destinationVC.trueNumber = trueNumber
    }
    
    func generateRandomNumber() -> Int{
        randomNumber = Int.random(in: 0...(totalFlagList.count-1))
        return randomNumber
    }
    
    func checkAnswer(button:UIButton){
        let givenAnswer = button.titleLabel?.text
        let correctAnswer = correctFlag.flag_name!
        
        print(givenAnswer!)
        print(correctAnswer)
        
        if(givenAnswer! == correctAnswer){
            trueNumber+=1
        }else{
            falseNumber+=1
        }
    }
    func determineQuestion(){
        currentQuestionNumber += 1
       
        if(currentQuestionNumber != 5){
            
            loadQuestion()
        }else{
            performSegue(withIdentifier: "toResultPage", sender: nil)

        }
    }
    
    @IBAction func buttonAClick(_ sender: Any) {
        checkAnswer(button: buttonA)
        determineQuestion()
    }
    
    @IBAction func buttonBClick(_ sender: Any) {
        checkAnswer(button: buttonB)
        determineQuestion()
    }
    @IBAction func buttonCClick(_ sender: Any) {
        checkAnswer(button: buttonC)
        determineQuestion()
    }
    @IBAction func buttonDClick(_ sender: Any) {
        checkAnswer(button: buttonD)
        determineQuestion()
    }
}
