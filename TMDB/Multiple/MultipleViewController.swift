//
//  MultipleViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/09/02.
//

import Foundation

class MultipleViewcontroller: BaseViewController{
    
    let mainView = MultipleView()
    
    override func loadView() {
        self.view = mainView
    }
    let multiTypeList = MultipleMediaType.allCases
    var list: [[MultipleResult]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        
    }
    
    override func setUpView() {
        super.setUpView()
    }
    
    override func setConstraints() {
        
    }
    
    override func setDelegate() {
        
    }
}

extension MultipleViewcontroller {
    func callRequest(){
        MovieAPIManager.shared.callRequestAll(type: .all) { data in
//            let movie = data.filter { data in
//                return data.mediaType == .movie
//            }
            self.multiTypeList.forEach { type in
                self.list.append(data.filter { data in
                    return data.mediaType == type
                })
            }
            
            dump(self.list)
            print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
            print("list 0 : ",self.list[0])
            print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
            print("list 1 : ",self.list[1])
            print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
            print("list 2 : ",self.list[2])
        }
    }
}
