//
//  FeedCollectionViewCell.swift
//  NewsFeed
//
//  Created by Sweta Sinha on 08/05/2025.
//

import Foundation
import UIKit

class FeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var newsTitle: UILabel!

    var currentTask: URLSessionDataTask?

    override func prepareForReuse() {
        super.prepareForReuse()

        currentTask?.cancel()
        imageView.image = UIImage(named: "placeholder")
        newsTitle.text = nil
    }

    func configure(imageURL: String, newsTitle: String) {

        self.newsTitle.text = newsTitle

       // load(url: URL(string: imageURL)!)

        loadImage(url: URL(string: imageURL)!)
    }

    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
        }
    }

    func loadImage(url: URL) {

        currentTask?.cancel()

        imageView.image = UIImage(named: "placeholder")

        currentTask = URLSession.shared.dataTask(with: url) { data, response, error in

            if let error {
                return
            }

            if let data {

                if let image =  UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }

        }

        currentTask?.resume()

    }

}
