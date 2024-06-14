//
//  CollectionViewCell.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 10.06.2024.
//

import Foundation
import UIKit

class ProductCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view.disableAutoresizing
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.darkGray
        return label.disableAutoresizing
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        return label.disableAutoresizing
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20

        addSubview(imageView)
        addSubview(priceLabel)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            imageView.widthAnchor.constraint(equalToConstant: bounds.width),
            imageView.heightAnchor.constraint(equalToConstant: bounds.width / 1.2),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            titleLabel.widthAnchor.constraint(equalToConstant: bounds.width - 20),
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
        
        
    }
    
    //MARK: Configure
    
    func configure(_ product: Product) {
        
        priceLabel.text = "\(product.price) $"
        titleLabel.text = product.title
        

            NetworkManager.shared.fetchImage(url: product.image) { result in

                switch result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        self.imageView.image = image
                    }
                case .failure(let error):
                    print(error)
                }
            }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
