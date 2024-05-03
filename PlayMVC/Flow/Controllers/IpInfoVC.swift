//
//  SecondVC.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//

import UIKit
import MapKit

final class IpInfoVC: UIViewController {
    
    private var ipInfo: IPAddressInfo?
    private var infoArray: [String : String] = [:]
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let action = UIAction { [weak self] _ in
            self?.handleRefresh(refreshControl)
        }
        refreshControl.addAction(action, for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .darkGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var reloadButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = button.frame.size.width / 2
        let action = UIAction { [weak self] _ in
            self?.reloadData()
        }
        button.addAction(action, for: .touchUpInside)
        button.setLargeImage(systemName: "arrow.clockwise")
        return button
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    init() {
        super.init(nibName: "IpInfoVC", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        
        setupTableView()
        setupActivityIndicator()
        setupReloadButton()
        reloadData()
        tableView.addSubview(refreshControl)
    }
    
    private func setupTableView() {
        let nibCell = UINib(nibName: "InfoCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "InfoCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isHidden = true
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }
    
    private func setupReloadButton() {
        view.addSubview(reloadButton)
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            reloadButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            reloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadButton.widthAnchor.constraint(equalToConstant: 140),
            reloadButton.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
}
//MARK: updateUI
extension IpInfoVC {
    func updateUI(with ipInfo: IPAddressInfo) {
        self.ipInfo = ipInfo
        infoArray = ipInfo.infoDictionary
        tableView.reloadData()
        let center = ipInfo.coordinate
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        self.mapView.setRegion(region, animated: true)
    }
    
    func startAnimation() {
        self.activityIndicator.startAnimating()
        self.mapView.isHidden = true
        self.tableView.isHidden = true
        self.reloadButton.rotate360Degrees()
    }
    
    func stopAnimation() {
        self.mapView.isHidden = false
        self.tableView.isHidden = false
        self.activityIndicator.stopAnimating()
        self.reloadButton.layer.removeAllAnimations()
    }
    //MARK: reloadData
    func reloadData() {
        NetworkManager.shared.loadData(endpoint: endpoint, decodeType: IPAddressInfo.self) { [weak self] (ipInfo) in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.startAnimation()
            }
            if let ipInfo = ipInfo {
                print("Decoded data: \(ipInfo)")
                DispatchQueue.main.async {
                    strongSelf.updateUI(with: ipInfo)
                    strongSelf.stopAnimation()
                }
            } else {
                if let cachedIPInfo: IPAddressInfo = CacheManager.shared?.getCachedData(for: endpoint, decodeType: IPAddressInfo.self) {
                    DispatchQueue.main.async {
                        strongSelf.updateUI(with: cachedIPInfo)
                    }
                    print("get Cached")
                }
            }
        }
    }
    //MARK: Refresh
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension IpInfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell
        
        let infoKey = Array(infoArray.keys)[indexPath.row]
        let infoValue = infoArray[infoKey]
        cell?.configure(with: (infoKey, infoValue ?? ""))
        return cell ?? InfoCell()
    }
}
