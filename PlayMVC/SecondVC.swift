//
//  SecondVC.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire

class SecondVC: UIViewController, CLLocationManagerDelegate {

    var ipInfo: IPAddressInfo?

    required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
      }

      init() {
          super.init(nibName: "SecondVC", bundle: nil)
      }

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var infoLabel: UILabel!

    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        loadIPData()
    }

//    @IBAction func reloadButtonTapped(_ sender: Any) {
//        loadIPData()
//    }

    func loadIPData() {
        AF.request("http://ip-api.com/json/?fields=61439",  method: .get).responseJSON { (response: AFDataResponse<Any>) in
            switch response.result {
            case .success(let value):
                if let json = value as? [String: Any] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                        let decoder = JSONDecoder()
                        let ipInfo = try decoder.decode(IPAddressInfo.self, from: jsonData)
                        self.ipInfo = ipInfo // Сохраняем ipInfo в self.ipInfo
                        print("Decoded data: \(ipInfo)") // Используем ipInfo вместо self.ipInfo!
                        DispatchQueue.main.async {
                            UIView.transition(with: self.infoLabel,
                                               duration: 0.25,
                                               options: .transitionCrossDissolve,
                                               animations: { self.infoLabel.text = "\(ipInfo)" }) // Используем ipInfo вместо self.ipInfo!
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         // Используйте ipInfo здесь
         if let ipInfo = ipInfo {
             let center = CLLocationCoordinate2D(latitude: ipInfo.lat, longitude: ipInfo.lon)
             let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
             self.mapView.setRegion(region, animated: true)
         }
     }
 }

