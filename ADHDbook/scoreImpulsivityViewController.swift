//
//  scoreImpulsivityViewController.swift
//  ADHDbook
//
//  Created by emi oiso on 2024/11/17.
//

import UIKit

class scoreImpulsivityViewController: UIViewController {
    @IBOutlet weak var scoreImpulsivityLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    var correct = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreImpulsivityLabel.text = "Yesの数 : \(correct) 問"
        
        // 今日の日付と時間を取得
        let now = Date()
        let dateFormatter = DateFormatter()
        //曜日を含むフォーマット
        dateFormatter.dateFormat = "yyyy年MM月dd日 (EEE) HH:mm"
        // 日本語形式
        dateFormatter.locale = Locale(identifier: "ja_JP")
        // フォーマットした日付・曜日・時間をUILabelに表示
        dateTimeLabel.text = dateFormatter.string(from: now)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toTopButtouAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
}
    
