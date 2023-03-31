//
//  ViewController.swift
//  music
//
//  Created by 余艳辉 on 2023/3/31.
//

import Moya
import RxSwift
import SnapKit
import SwiftyJSON
import UIKit

class ViewController: UIViewController {
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = MoyaProvider<MusicApi>()
        
        provider.rx.request(.getQRKey).subscribe { event in
            switch event {
            case let .success(response):
                print(response)
                do {
                    let json = try JSON(data: response.data)

                    let key = json["data"]["unikey"].stringValue
                    print("获取到key = \(key)")

                } catch {
                    print(error)
                }
                    
            case let .failure(error):
                print(error)
            }
        }
        .disposed(by: bag)
    }
}
