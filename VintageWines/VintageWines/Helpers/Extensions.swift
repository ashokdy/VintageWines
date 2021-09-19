//
//  Extensions.swift
//  VintageWines
//
//  Created by ashokdy on 17/09/2021.
//

import UIKit

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode = .scaleAspectFit) {
        URLSession.shared.dataTask(with: URL(string: link)!, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}

public extension Array {
    /// Safely returns an element at the given index if it exists.
    func at(_ index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}

extension UIViewController {
    
    func showAlert(titleText: String = "Error!", messageText : String) {
        let alert = UIAlertController(title: titleText,
                                      message: messageText,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func showLoading() -> UIAlertController {
        let alert = UIAlertController(title: "Loading...",
                                      message: nil,
                                      preferredStyle: .alert)
        self.present(alert, animated: true)
        return alert
    }
}
