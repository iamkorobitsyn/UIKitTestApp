//
//  CollectionViewCell.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 10.06.2024.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .green
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView.disableAutoresizing
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "50"
        return label.disableAutoresizing
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label.disableAutoresizing
    }()
    
    var imageList: [UIImage] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .yellow
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        addSubview(priceLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalToConstant: bounds.width),
            collectionView.heightAnchor.constraint(equalToConstant: bounds.width),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            descriptionLabel.widthAnchor.constraint(equalToConstant: bounds.width - 20),
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
            
        ])
    }
    
    func configure(with: Product) {
        imageList = []
    
        priceLabel.text = "\(with.price) $"
        descriptionLabel.text = with.description
        
        let group = DispatchGroup()
                
        with.images.forEach { urlString in
                    group.enter()
            NetworkManager.schared.fetchImage(url: urlString) { result in
                        defer { group.leave() }
                        switch result {
                        case .success(let data):
                            if let image = UIImage(data: data) {
                                self.imageList.append(image)

                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                
                group.notify(queue: .main) {
                    self.collectionView.reloadData()
                }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let imageView = UIImageView(image: imageList[indexPath.row])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        cell.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: cell.leadingAnchor)
        ])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: bounds.width, height: bounds.width)
    }

    
    
}
