//
//  TimeCircuitsViewController.swift
//  OutaTime
//
//  Created by Wesley Ryan on 3/25/20.
//  Copyright © 2020 Wesley Ryan. All rights reserved.
//

import UIKit

class TimeCircuitsViewController: UIViewController {
    @IBOutlet weak var detinationTimeLabel: UILabel!
    @IBOutlet weak var presentTimeLabel: UILabel!
    @IBOutlet weak var lastTimeDepartedLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    var speed = 0
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        presentTimeLabel.text = dateFormatter.string(from: date)
        speedLabel.text = "\(speed) MPH"
        lastTimeDepartedLabel.text = "___ __ ___"
        detinationTimeLabel.text = "Choose a Date"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func setDestinationTimeButton(_ sender: Any) {
    }
    
    @IBAction func travelBackButton(_ sender: Any) {
        startTimer()
        print("Button Fired")
    }
    
    func startTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateSpeed(timer:))
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        print("Timer Reset")
    }
    
    func updateSpeed(timer: Timer) {
        if speed < 88 {
           speed += 1
            speedLabel.text = "\(speed) MPH"
        } else {
            timer.invalidate()
            speedLabel.text = "\(speed) MPH"
            lastTimeDepartedLabel.text = presentTimeLabel.text
            presentTimeLabel.text = detinationTimeLabel.text
            speed = 0
            showAlert()

        }
        
    }
    
   func showAlert() {
    
            let alert = UIAlertController(title: "Time Travel Successful",
    message: "Your new date is \(detinationTimeLabel.text!) ", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            
        }
    
    
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DatePickerSegue" {
            guard let newVc = segue.destination as? DatePickerViewController else {return}
            
            newVc.delegate = self
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension TimeCircuitsViewController: DatePickerDelegate {
    func destinationDateWasChosen(date: Date) {
        detinationTimeLabel.text = dateFormatter.string(from: date)
    }
    
    
}
