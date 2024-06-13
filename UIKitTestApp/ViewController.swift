//
//  ViewController.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 05.06.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let collectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView.disableAutoresizing
    }()
    
    var products: [Product] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchContent(endPoint: .products)
    }
    
    //MARK: - setupUI
    
    private func setupUI() {
        view.backgroundColor = .systemGray5
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            
        ])
        
    }
    
    
    //MARK: - FetchContent
    
    private func fetchContent(endPoint: EndPoints) {

        NetworkManager.shared.fetchData(type: [Product].self, endPoint: endPoint) { result in
            
            switch result {
                
            case .success(let data):
                self.products = data
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            
            let product = products[indexPath.row]
            cell.configure(product)
           
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 25, height: view.bounds.width / 1.5)
    }
}
