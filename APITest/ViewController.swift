//
//  ViewController.swift
//  APITest
//
//  Created by 이상헌 on 2021/08/08.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherMainLabel: UILabel!
    @IBOutlet weak var shoesImage: UIImageView!
    @IBOutlet weak var todayShoesButton: UIButton!
    
    @IBAction func buttonDidTap(_ sender: Any) {
        WeatherRequest().getWeatherData(self)
    }
    //카카오 소셜로그인
    @IBOutlet weak var kakaoLoginApp: UIButton!
    //카카오 로그인 버튼 구현
    @IBAction func kakaoLoginAppTouched(_ sender: Any) {
        // 카카오톡 설치 여부 확인
          if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    // 예외 처리 (로그인 취소 등)
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                   // do something
                    _ = oauthToken
                   // 어세스토큰
//                   let accessToken = oauthToken?.accessToken
                    self.getUserData()
                    self.loginAlert()
                }
            }
          } else {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                    self.getUserData()
                    self.loginAlert()
                }
            }
          }
    }
    func loginAlert() {
        let alert = UIAlertController(title: "성공!", message: "로그인 되었습니다.", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler : nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //button UI 수정
        self.kakaoLoginApp.setImage(UIImage(named: "kakao_login_large_narrow"), for: .normal)
        //button UI 수정
        self.todayShoesButton.setTitle("오늘 날씨엔 신발 뭐 신지??", for: .normal)
        self.todayShoesButton.backgroundColor = .orange
        self.todayShoesButton.titleLabel?.font = UIFont(name: "system", size: 20)
        self.todayShoesButton.setTitleColor(.white, for: .normal)
        self.todayShoesButton.layer.cornerRadius = 15
        //Label 빈 값 넣기
        self.weatherMainLabel.text = ""
    }
    //카카오 사용자 정보 받아오기
    func getUserData() {
        //카카오 사용자 정보 받아오기
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")

                //do something
                _ = user
                let gender = user?.kakaoAccount?.gender
                    //print(gender)
            }
        }
    }
}

extension ViewController {
    //weather open api response
    func didSuccess(_ response: weatherResponse){
        
        var weatherMain = response.weather[0].main
        //카카오 사용자 정보 받아오기
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")

                //do something
                _ = user
                let gender = user?.kakaoAccount?.gender
                //print(gender!.rawValue)
                //print(gender)
                self.weatherMainLabel.text = "오늘의 신발은?"
                if weatherMain == "Clear" {
                    if (gender!).rawValue == "male" {
                        self.shoesImage.image = UIImage(named: "남자운동화")
                } else {
                    self.shoesImage.image = UIImage(named: "여자운동화")
                    }
                }
                
                else if weatherMain == "Clouds" {
                    if (gender!).rawValue == "male" {
                        self.shoesImage.image = UIImage(named: "남자샌들")
                } else {
                    self.shoesImage.image = UIImage(named: "여자샌들")
                    }
                } else { return }
            }
        }
    }
}

    

