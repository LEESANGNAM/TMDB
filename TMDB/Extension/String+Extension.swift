//
//  String+Extension.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/29.
//

import Foundation


extension String{
    func changeFormatDateString() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: self) {
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let changeFormatDate = dateFormatter.string(from: date)
                return "\(changeFormatDate)"
            } else {
                return "\(self)"
            }
        }
}
