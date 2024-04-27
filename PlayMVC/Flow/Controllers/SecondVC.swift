//
//  SecondVC.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//

import UIKit
import MapKit

class SecondVC: UIViewController {

    private var ipInfo: IPAddressInfo?
    private let endpoint = "http://ip-api.com/json/?fields=66846719"
    private var infoArray: [(String, String)] = []

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .darkGray
        indicator.hidesWhenStopped = true
        return indicator
    }()

    lazy var reloadButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 140, height: 140)
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = button.frame.size.width / 2
        button.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        button.setLargeImage(systemName: "arrow.clockwise")
        return button
    }()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(nibName: "SecondVC", bundle: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let nibCell = UINib(nibName: "InfoCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "InfoCell")

        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(reloadButton)
        view.addSubview(activityIndicator)
        mapView.isHidden = true
        tableView.isHidden = true

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            reloadButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            reloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reloadButton.widthAnchor.constraint(equalToConstant: 140),
            reloadButton.heightAnchor.constraint(equalToConstant: 140)
        ])

        tableView.estimatedRowHeight = 44

        reloadData()
    }
}

//MARK: updateUI
extension SecondVC {
    func updateUI(with ipInfo: IPAddressInfo) {
        self.ipInfo = ipInfo
        infoArray = [
            ("IP", ipInfo.query),
            ("ISP", ipInfo.isp),
            ("Organization", ipInfo.org),
            ("Country", "\(ipInfo.country) (\(ipInfo.countryCode))"),
            ("Region", "\(ipInfo.regionName) (\(ipInfo.region))"),
            ("City", ipInfo.city),
            ("Zip Code", ipInfo.zip),
            ("Timezone", ipInfo.timezone),
            ("Latitude", "\(ipInfo.lat)"),
            ("Longitude", "\(ipInfo.lon)")
        ]
        tableView.reloadData()

        let center = CLLocationCoordinate2D(latitude: ipInfo.lat, longitude: ipInfo.lon)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        self.mapView.setRegion(region, animated: true)
    }
}

//MARK: reloadData
@objc extension SecondVC {
    func reloadData() {
        NetworkManager.shared.loadData(endpoint: endpoint, decodeType: IPAddressInfo.self) { (ipInfo) in
            self.activityIndicator.startAnimating()
            self.mapView.isHidden = true
            self.tableView.isHidden = true
            if let ipInfo = ipInfo {
                print("Decoded data: \(ipInfo)")
                DispatchQueue.main.async {

                    self.mapView.isHidden = false
                    self.tableView.isHidden = false
                    self.updateUI(with: ipInfo)
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension SecondVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell
        
        let info = infoArray[indexPath.row]
        cell?.titleInfoCellLabel.text = info.0
        cell?.detailInfoCellLabel.text = info.1
        return cell ?? UITableViewCell()
    }
}

