//
//  ViewController.swift
//  MyLocation
//
//  Created by 关东升 on 2016-11-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //经度
    @IBOutlet weak var txtLng: UITextField!
    //纬度
    @IBOutlet weak var txtLat: UITextField!
    //高度
    @IBOutlet weak var txtAlt: UITextField!
    
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        //定位服务管理对象初始化
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 1000.0
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        //设置自动暂停位置服务
        self.locationManager.pausesLocationUpdatesAutomatically = true
        self.locationManager.activityType = .automotiveNavigation

        self.locationManager.allowsBackgroundLocationUpdates = true
        
        //开始定位
        self.locationManager.startUpdatingLocation()
        print("开始定位")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //停止定位
        self.locationManager.stopUpdatingLocation()
        print("停止定位")
    }

    //MARK: --Core Location委托方法用于实现位置的更新
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currLocation = locations.last! as CLLocation
        
        self.txtLat.text = String(format:"%3.5f", currLocation.coordinate.latitude)
        self.txtLng.text = String(format:"%3.5f", currLocation.coordinate.longitude)
        self.txtAlt.text = String(format:"%3.5f", currLocation.altitude)
        
        print("位置更新")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways :
            print("已经授权")
        case .authorizedWhenInUse :
            print("当使用时候授权")
        case .denied :
            print("拒绝")
        case .restricted :
            print("受限")
        case .notDetermined:
            print("用户还没有确定")
        }
        
    }

}
