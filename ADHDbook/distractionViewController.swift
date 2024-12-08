//
//  distractionViewController.swift
//  ADHDbook
//
//  Created by emi oiso on 2024/11/16.
//

import UIKit
import GoogleMobileAds

class distractionViewController: UIViewController {
    @IBOutlet weak var distractionNumberLabel: UILabel!
    @IBOutlet weak var distractionTextView: UITextView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var bannerView: GADBannerView!
    var csvArray: [String] = []
    var distractionArray: [String] = []
    var distractionCount = 0
    var correctCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-7923877881339580/6704043176"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
        
        csvArray = loadCSV(fileName: "distraction")
        print(csvArray)
        
        distractionArray = csvArray[distractionCount].components(separatedBy: ",")
        distractionNumberLabel.text = "\(distractionCount + 1) / 3"
        distractionTextView.text = distractionArray[0]
        yesButton.setTitle(distractionArray[2], for: .normal)
        noButton.setTitle(distractionArray[3], for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! scoreDistractionViewController
        scoreVC.correct = correctCount
    }
    
    //ボタンを押した時に呼ばれる
    @IBAction func btnAction(sender: UIButton) {
        if sender.tag == Int(distractionArray[1]) {
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
        distractionCount += 1
        if distractionCount < csvArray.count {
            distractionArray = csvArray[distractionCount].components(separatedBy: ",")
            distractionNumberLabel.text = "\(distractionCount + 1) / 3"
            distractionTextView.text = distractionArray[0]
            yesButton.setTitle(distractionArray[2], for: .normal)
            noButton.setTitle(distractionArray[3], for: .normal)
            
        } else {
            performSegue(withIdentifier: "toScoreDistraction", sender: nil)
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
//    広告
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
        [NSLayoutConstraint(item: bannerView,
                    attribute: .bottom,
                    relatedBy: .equal,
                    toItem: view.safeAreaLayoutGuide,
                    attribute: .bottom,
                    multiplier: 1,
                    constant: 0),
         NSLayoutConstraint(item: bannerView,
                    attribute: .centerX,
                    relatedBy: .equal,
                    toItem: view,
                    attribute: .centerX,
                    multiplier: 1,
                    constant: 0)
        ])
    }
}
