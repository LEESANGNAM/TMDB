//
//  MultipleViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/09/02.
//

import UIKit

class MultipleViewcontroller: BaseViewController{
    
    let mainView = MultipleView()
    
    override func loadView() {
        self.view = mainView
    }
    let multiTypeList = MultipleMediaType.allCases
    var list: [[MultipleResult]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        callRequest()
        
    }
    
    override func setUpView() {
        super.setUpView()
        registerCell()
    }
    
    override func setConstraints() {
        
    }
    
    override func setDelegate() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    func registerCell(){
        mainView.tableView.register(MultipleMovieTableViewCell.self, forCellReuseIdentifier: MultipleMovieTableViewCell.identifier)
        mainView.tableView.register(MultipleTvTableViewCell.self, forCellReuseIdentifier: MultipleTvTableViewCell.identifier)
        mainView.tableView.register(MultiplePersonTableViewCell.self, forCellReuseIdentifier: MultiplePersonTableViewCell.identifier)
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


extension MultipleViewcontroller: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 3 == 0 {
            guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: MultipleMovieTableViewCell.identifier) as? MultipleMovieTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .systemRed
            return cell
        } else if indexPath.row % 3 == 1{
            guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: MultipleTvTableViewCell.identifier) as? MultipleTvTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .systemGray
            return cell
        } else {
            guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: MultiplePersonTableViewCell.identifier) as? MultiplePersonTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .systemYellow
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
