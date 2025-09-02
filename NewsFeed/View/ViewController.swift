//
//  ViewController.swift
//  NewsFeed
//
//  Created by Sweta Sinha on 08/05/2025.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,
    UICollectionViewDelegate
{

    @IBOutlet weak var feedCollectionView: UICollectionView!

    let viewModel: FeedCollectionViewModel!

//    let repository: DataRepository!
//
//    let networkService: NetworkService!
//
//    var photos: [Photo] = []
//
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {

//        networkService = NetworkServiceImpl()
//        repository = DatarepositoryImpl(networkService: networkService)

        let networkService = NetworkServiceImpl()
        let repository = DatarepositoryImpl(networkService: networkService)

        viewModel = FeedCollectionViewModel(networkService: networkService, repository: repository)

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }

    required init?(coder aDecoder: NSCoder) {

//        networkService = NetworkServiceImpl()
//        repository = DatarepositoryImpl(networkService: networkService)

        let networkService = NetworkServiceImpl()
        let repository = DatarepositoryImpl(networkService: networkService)

        viewModel = FeedCollectionViewModel(networkService: networkService, repository: repository)

        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self

        self.feedCollectionView.register(
            UINib(nibName: "FeedCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "feedCollectionViewCell")

        if let flowLayout = feedCollectionView.collectionViewLayout
            as? UICollectionViewFlowLayout
        {

            flowLayout.minimumLineSpacing = 0
        }

        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {

                self?.feedCollectionView.reloadData()
            }
        }
    }

//    func loadNewsFeed() {
//
//        Task {
//            do {
//                let newsFeedResult = try await repository.fetchNewsFeed()
//
//                DispatchQueue.main.async {
//
//                    self.photos = newsFeedResult.photos
//
//                    self.feedCollectionView.reloadData()
//                }
//
//            } catch {
//                print(error)
//            }
//        }
//
//    }

    func collectionView(
        _ collectionView: UICollectionView, numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.photos.count
    }

    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "feedCollectionViewCell", for: indexPath)
            as? FeedCollectionViewCell
        {

            cell.configure(
                imageURL: viewModel.photos[indexPath.row].url,
                newsTitle: viewModel.photos[indexPath.row].title)

            return cell

        }

        return UICollectionViewCell()
    }

    func collectionView(
        _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath
    ) {

        if let detailsVC = UIStoryboard(
            name: "DetailsViewController", bundle: nil
        ).instantiateViewController(withIdentifier: "DetailsViewController")
            as? DetailsViewController
        {

            detailsVC.photo = viewModel.photos[indexPath.row]
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}
