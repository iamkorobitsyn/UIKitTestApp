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
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let getButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad() 
        setViews()
        setConstraints()
        fetchContent(url: "https://api.escuelajs.co/api/v1/products")
    }
    
    //MARK: - FetchContent
    
    private func fetchContent(url: String) {

        NetworkManager.schared.fetchData(type: [Product].self,
                                         url: url) { result in
            
            switch result {
                
            case .success(let data):
                print(data.count)
                
                print(data[10].price)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - SetViews
    
    private func setViews() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(getButton)
        view.addSubview(resetButton)
    }
    
    //MARK: - SetConstraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            getButton.widthAnchor.constraint(equalToConstant: 50),
            getButton.heightAnchor.constraint(equalToConstant: 50),
            getButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 50),
            getButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                              constant: -50),
            
            resetButton.widthAnchor.constraint(equalToConstant: 50),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: -50),
            resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                constant: -50)
        ])
    }
}

    //MARK: - TableViewDataSourse&Delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .blue
        return cell
    }
}

