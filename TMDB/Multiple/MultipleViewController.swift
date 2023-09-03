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
        callRequest()
        
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
        MovieAPIManager.shared.callRequest(type: .all) { (data: Multiple) in
            let results = data.results
            self.multiTypeList.forEach { type in
                self.list.append(results.filter { data in
                    return data.mediaType == type
                })
            }
            self.mainView.tableView.reloadData()
        }
    }
}


extension MultipleViewcontroller: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return multiTypeList.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return multiTypeList[section].rawValue
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < list.count else {
                return 0
            }
        if section == 0 {
            return list[section].count
        } else if section == 1{
            return list[section].count
        } else {
            return list[section].count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = list[indexPath.section][indexPath.row]
        if indexPath.section == 0 {
            guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: MultipleMovieTableViewCell.identifier,for: indexPath) as? MultipleMovieTableViewCell else { return UITableViewCell() }
            cell.setCellData(movie: data)
            return cell
        } else if indexPath.section == 1{
            guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: MultiplePersonTableViewCell.identifier,for: indexPath) as? MultiplePersonTableViewCell else { return UITableViewCell() }
            cell.setCellData(person: data)
            return cell
        } else {
            guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: MultipleTvTableViewCell.identifier,for: indexPath) as? MultipleTvTableViewCell else { return UITableViewCell() }
            cell.setCellData(movie: data)
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
