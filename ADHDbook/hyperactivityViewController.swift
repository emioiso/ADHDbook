//
//  distractionViewController.swift
//  ADHDbook
//
//  Created by emi oiso on 2024/11/16.
//

import UIKit

class hyperactivityViewController: UIViewController {
    @IBOutlet weak var hyperactivityNumberLabel: UILabel!
    @IBOutlet weak var hyperactivityTextView: UITextView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var csvArray: [String] = []
    var hyperactivityArray: [String] = []
    var hyperactivityCount = 0
    var correctCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        csvArray = loadCSV(fileName: "hyperactivity")
        print(csvArray)
        
        hyperactivityArray = csvArray[hyperactivityCount].components(separatedBy: ",")
        hyperactivityNumberLabel.text = "\(hyperactivityCount + 1) / 3"
        hyperactivityTextView.text = hyperactivityArray[0]
        yesButton.setTitle(hyperactivityArray[2], for: .normal)
        noButton.setTitle(hyperactivityArray[3], for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! scoreHyperactivityViewController
        scoreVC.correct = correctCount
    }
    
    //ボタンを押した時に呼ばれる
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(hyperactivityArray[1]) {
            correctCount += 1
            print("YES")
        } else {
            print("NO")
        }
        print("スコア：\(correctCount)")
        nextQuiz()
    }
    func nextQuiz() {
        // 問題番号を進める
        hyperactivityCount += 1
        if hyperactivityCount < csvArray.count {
            hyperactivityArray = csvArray[hyperactivityCount].components(separatedBy: ",")
            hyperactivityNumberLabel.text = "\(hyperactivityCount + 1) / 3"
            hyperactivityTextView.text = hyperactivityArray[0]
            yesButton.setTitle(hyperactivityArray[2], for: .normal)
            noButton.setTitle(hyperactivityArray[3], for: .normal)
            
        } else {
            performSegue(withIdentifier: "toScoreHyperactivity", sender: nil)
        }
        
    }
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
        let csvData = try String(contentsOfFile: csvBundle,encoding: String.Encoding.utf8)
        let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
        csvArray = lineChange.components(separatedBy: "\n")
        csvArray.removeLast()
        } catch {
        print("エラー")
        }
        return csvArray
    }
}
