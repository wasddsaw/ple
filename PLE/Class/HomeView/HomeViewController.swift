//
//  HomeViewController.swift
//  PLE
//
//  Created by Lukman Hakim Japri on 05/07/2019.
//  Copyright © 2019 Lukman Hakim Japri. All rights reserved.
//
import UIKit
class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data: [[String : Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad HomeViewController")
        setupView()
    }
    
    func setupView() -> Void {
        let cellNib = UINib(nibName: "imageSliderViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cvCell")
        
        data = [
            ["image": "https://via.placeholder.com/350x150.png"],
            ["image": "https://via.placeholder.com/350x150.png"],
            ["image": "https://via.placeholder.com/350x150.png"],
            ["image": "https://via.placeholder.com/350x150.png"],
        ]
        
        let frame: CGRect = UIScreen.main.bounds
        
        let flowLayout = UICollectionViewFlowLayout()
        let width = Int(frame.size.width)
        
        let cellWidth = Int(Double(width))
        let cellHeight = Int(Double(width))
        flowLayout.itemSize = CGSize(width: CGFloat(cellWidth), height: CGFloat(cellHeight))
        flowLayout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.reloadData()
    }
    
    //MARK: - Collection View
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let key = data[indexPath.row]
        let collectionViewCellIdentifier = "cvCell"
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.clear
        let imageView = cell.viewWithTag(100) as? UIImageView
        
        imageView?.contentMode = .scaleAspectFit
        
        let url = URL(string: key["image"] as! String)
        do {
            let data = try Data(contentsOf: url!)
            imageView?.image = UIImage(data: data)
            
        }catch let err {
            print("Error : \(err.localizedDescription)")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath.row : \(indexPath.row)")
    }
}
