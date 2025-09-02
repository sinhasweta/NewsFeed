//
//  DetailsViewController.swift
//  NewsFeed
//
//  Created by Sweta Sinha on 14/05/2025.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    var photo: Photo?

    override func viewDidLoad() {

        super.viewDidLoad()

        label.text = photo?.title

    }
}
