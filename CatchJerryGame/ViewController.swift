//
//  ViewController.swift
//  CatchKarlGame
//
//  Created by Pelinsu Celebi on 13.08.2020.
//  Copyright © 2020 Pelinsu Celebi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer = Timer()
    var score = 0
    var highscore = 0
    var counter = 0
    var jerryArray = [UIImageView]()
    
    var hideTimer = Timer()
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var jerry1: UIImageView!
    @IBOutlet weak var jerry2: UIImageView!
    
    @IBOutlet weak var jerry3: UIImageView!
    @IBOutlet weak var jerry4: UIImageView!
    
    @IBOutlet weak var jerry5: UIImageView!
    
    @IBOutlet weak var jerry6: UIImageView!
    
    @IBOutlet weak var jerry7: UIImageView!
    
    @IBOutlet weak var jerry8: UIImageView!
    
    @IBOutlet weak var jerry9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text = "Score: \(score)"
        
        
        let storedHighScore = UserDefaults.standard.object(forKey: "HighScore")
        
        if storedHighScore == nil {
            
            highscore = 0
            highScoreLabel.text = "Highscore: \(highscore)"
        }
        
        if let newScore = storedHighScore as? Int{
            
            highscore = newScore
            highScoreLabel.text = "Highscore: \(highscore)"
        }
        
        jerry1.isUserInteractionEnabled = true
        jerry2.isUserInteractionEnabled = true
        jerry3.isUserInteractionEnabled = true
        jerry4.isUserInteractionEnabled = true
        jerry5.isUserInteractionEnabled = true
        jerry6.isUserInteractionEnabled = true
        jerry7.isUserInteractionEnabled = true
        jerry8.isUserInteractionEnabled = true
        jerry9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        jerry1.addGestureRecognizer(recognizer1)
        jerry2.addGestureRecognizer(recognizer2)
        jerry3.addGestureRecognizer(recognizer3)
        jerry4.addGestureRecognizer(recognizer4)
        jerry5.addGestureRecognizer(recognizer5)
        jerry6.addGestureRecognizer(recognizer6)
        jerry7.addGestureRecognizer(recognizer7)
        jerry8.addGestureRecognizer(recognizer8)
        jerry9.addGestureRecognizer(recognizer9)
        
        jerryArray = [jerry1, jerry2, jerry3, jerry4, jerry5, jerry6, jerry7, jerry8, jerry9]
        
        //Timers
        
        counter = 10
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideJerry), userInfo: nil, repeats: true)
        
 
        
    }
    
    @objc func hideJerry(){
        
        for jerry in jerryArray {
            
            jerry.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(jerryArray.count - 1)))
        jerryArray[random].isHidden = false
    }

    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            
            timer.invalidate()
            hideTimer.invalidate()
            for jerry in jerryArray {
                
                jerry.isHidden = true
            }
            
            
            //HighScore
            
            if self.score > self.highscore{
                
                self.highscore = self.score
                highScoreLabel.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "HighScore")
            }
            
            
            //alert
            
            let alert = UIAlertController(title: "Time is Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideJerry), userInfo: nil, repeats: true)
                
                
            }
            
            
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

