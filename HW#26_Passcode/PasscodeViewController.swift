//
//  PasscodeViewController.swift
//  HW#26_Passcode
//
//  Created by Dawei Hao on 2023/5/13.
//

import UIKit
import LocalAuthentication

class PasscodeViewController: UIViewController {
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var buttonFive: UIButton!
    @IBOutlet weak var buttonSix: UIButton!
    @IBOutlet weak var buttonSeven: UIButton!
    @IBOutlet weak var buttonEight: UIButton!
    @IBOutlet weak var buttonNine: UIButton!
    @IBOutlet weak var buttonZero: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var imageFour: UIImageView!
    @IBOutlet weak var titleOne: UILabel!
    @IBOutlet weak var titleTwo: UILabel!
    @IBOutlet weak var blackImageViewOne: UIImageView!
    @IBOutlet weak var blackImageViewTwo: UIImageView!
    @IBOutlet weak var blackImageViewThree: UIImageView!
    @IBOutlet weak var blackImageViewFour: UIImageView!
    
    //定義輸入成功的密碼，並建立一個array
    let passCode = [1,2,3,4]
    //建立變數，成一個array
    var keyInPassCode = [Int]()
    //建立變數，點擊次數等於0
    var countForTouch = 0
    //建立一個變數，blackImageView所有的數組
    var blackImageViews: [UIImageView] = []
    //建立一個變數，iconImageView所有的數組
    var iconImageViews: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //建立blackImageView的array
        blackImageViews = [blackImageViewOne, blackImageViewTwo, blackImageViewThree, blackImageViewFour]
        //建立iconImageView的array
        iconImageViews = [imageOne, imageTwo, imageThree, imageFour]
        //顯示黑色icon
        for imageView in blackImageViews {
            imageView.isHidden = false
        //帶入FaceID
       faceIdAndTouchId()
        }
    }
    
    //黑色造型的ImageView的顯示設定，顯示畫面
    func initialImage () {
        //關閉原有的icon，用for迴圈，找到iconImage的陣列，並且設定不顯示
        for imageView in iconImageViews {
            imageView.isHidden = true
        }
        //顯示黑底的icon，用for迴圈，找到iconImage的陣列，並且設定顯示。
        for imageView in blackImageViews {
            imageView.isHidden = false
        }
    }
    
    //點擊canelButton，一切重回初始設定
    @IBAction func cancelButtonTapped(_ sender: Any) {
        initialImage()
        //將keyInPassCode設置為空陣列
        keyInPassCode = []
        print("cancelButton Tapped")
        //點擊次數為0
        countForTouch = 0
        //編輯文本，將UILabel的文字，改成字串
        titleOne.text = "Enter Password"
        titleTwo.text = "Enter password below"
    }
    
    //建立輸入密碼並連帶更換imageView的畫面
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        if countForTouch < 4 {
            switch sender {
            case buttonZero:
                keyInPassCode.append(0)
                countForTouch += 1
                print("0")
            case buttonOne:
                keyInPassCode.append(1)
                countForTouch += 1
                print("1")
            case buttonTwo:
                keyInPassCode.append(2)
                countForTouch += 1
                print("2")
            case buttonThree:
                keyInPassCode.append(3)
                countForTouch += 1
                print("3")
            case buttonFour:
                keyInPassCode.append(4)
                countForTouch += 1
                print("4")
            case buttonFive:
                keyInPassCode.append(5)
                countForTouch += 1
                print("5")
            case buttonSix:
                keyInPassCode.append(6)
                countForTouch += 1
                print("6")
            case buttonSeven:
                keyInPassCode.append(7)
                countForTouch += 1
                print("7")
            case buttonEight:
                keyInPassCode.append(8)
                countForTouch += 1
                print("8")
            case buttonNine:
                keyInPassCode.append(9)
                countForTouch += 1
                print("9")
            default:
                countForTouch += 0
                print("index = 0")
            }; iconImageViews[countForTouch - 1 ].isHidden = false
            blackImageViews[countForTouch - 1].isHidden = true
        }; if keyInPassCode == passCode {
            confirmAlert()
            titleOne.text = "Sucessfull!"
            titleOne.textAlignment = .center
            titleTwo.text = ""
        } else if keyInPassCode.count == 4 && keyInPassCode != passCode {
            errorAlert()
            titleOne.text = "Enter Password Again"
            titleTwo.text = "Enter password below"
        }
    }
    
    //點擊delete button
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        //建立條件式，確立點擊次數至少一次和keyInPassCode的array不是空的
        if countForTouch <= 4 && !keyInPassCode.isEmpty {
            countForTouch -= 1
            keyInPassCode.removeLast()
            print("delete count equal \(countForTouch + 1)")
        //建立一個隱藏blackImageView的常數，在array裏面，設定將餘數等於1，並且將設定在陣列數組順序，將圖片隱藏。
         let hideblackImageView = blackImageViews[countForTouch - countForTouch % 1]
            hideblackImageView.isHidden = false
        } else if countForTouch == 0 {
            print("delete count equal \(countForTouch)")
        }
    }
    
    //登入成功畫面
    func confirmAlert() {
        let loginController = UIAlertController(title: "Login Success", message: "登入成功", preferredStyle: .alert)
        loginController.addAction(UIAlertAction(title: "確認", style: .default))
        self.present(loginController, animated: true)
    }
    
    //登入失敗畫面
    func errorAlert() {
        let errorController = UIAlertController(title: "Login Failed", message: "登入失敗", preferredStyle: .alert)
        errorController.addAction(UIAlertAction(title: "完成", style: .default))
        self.present(errorController, animated: true)
    }
    
    //使用faceid & Touchid
    func faceIdAndTouchId() {
        //呼叫LAContext，作為一個介面評估
        let context = LAContext()
        //建立變數，如果執行的方法失敗，NSError就會是nil
        var error: NSError? = nil
        //運用context裡面的canEvaluatePolicy的方法，檢查裝置是否能夠進行生物驗證，並運用deviceOwnerAuthenticationWithBiometrics policy的生物辨別技術來驗證裝置所有者的身份
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            //建立一個常數並將解釋原因
            let reason = "explanation for authentication"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                success, authenticationError in
               //如果登入成功，DispatchQueue.main 獲取了主線的dispatch queue。
                //Dispatch queue 是一種資料結構，用於管理在特定線程中需要進行的工作或任務。
               //async {} 是一種方法，用於將一個工作或任務非同步地加入到 dispatch queue 中。非同步地意味著這個工作或任務將在未來的某個時間點進行，並且它不會阻塞當前線程的其他工作或任務。
                if success {
                    DispatchQueue.main.async {
                        self.alert(with: "Authentication success!")
                    }
                } else {
                    print("Authentication failed!")
                }
             }
          } else {
              self.alert(with: "Authentication not available!")
       }
    }
    //建立private function，使用UIAlertController
    func alert(with message: String) {
        let alert = UIAlertController(title: "Login Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        self.present(alert, animated: true)
    }
}
