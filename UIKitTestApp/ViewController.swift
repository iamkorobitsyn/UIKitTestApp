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
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "productCell")
        return collectionView.disableAutoresizing
    }()
    
    var products: [Product] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchContent(endPoint: .products)
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        view.backgroundColor = .systemGray5
    }
    
    
    //MARK: - Fetch content
    
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

//MARK: - UICollectionView Delegate DataSource FlowLayout

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCell {
            
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
