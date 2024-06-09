//
//  ViewController.swift
//  UIKitTestApp
//
//  Created by Александр Коробицын on 05.06.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let getButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red.withAlphaComponent(0.7)
        button.layer.cornerRadius = 25
        button.setTitle("Categories", for: .normal)
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red.withAlphaComponent(0.7)
        button.layer.cornerRadius = 25
        button.setTitle("Products", for: .normal)
        return button
    }()
    
    var products: [Product] = []
    

    override func viewDidLoad() {
        super.viewDidLoad() 
        setViews()
        setConstraints()
        fetchContent(url: .products)
    }
    
    //MARK: - SetViews
    
    private func setViews() {
        view.backgroundColor = .systemGray5
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(getButton)
        view.addSubview(resetButton)
    }
    
    //MARK: - FetchContent
    
    private func fetchContent(url: EndPoints) {

        NetworkManager.schared.fetchData(type: [Product].self, url: url) { result in
            
            switch result {
                
            case .success(let data):
                self.products = data
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func showProducts() {
        
    }
    
    @objc private func showCategories() {
        
    }
    

    //MARK: - SetConstraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            getButton.widthAnchor.constraint(equalToConstant: 100),
            getButton.heightAnchor.constraint(equalToConstant: 50),
            getButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 50),
            getButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                              constant: -150),
            
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -50),
            resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                constant: -150)
        ])
    }
}

    //MARK: - TableViewDataSourse&Delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
            return cell
        }
        return UITableViewCell()
        
    }
}

