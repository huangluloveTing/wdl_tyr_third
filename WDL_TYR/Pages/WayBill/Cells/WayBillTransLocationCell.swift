//
//  WayBillTransLocationCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/17.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillTransLocationCell: BaseCell {

    @IBOutlet weak var mapViewContainer: WDLMapView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let lineCoordinates: [CLLocationCoordinate2D] = [
//            CLLocationCoordinate2D(latitude: 39.855539, longitude: 116.119037),
//            CLLocationCoordinate2D(latitude: 39.88539, longitude: 116.250285),
//            CLLocationCoordinate2D(latitude: 39.805479, longitude: 116.180859),
//            CLLocationCoordinate2D(latitude: 39.788467, longitude: 116.226786),
//            CLLocationCoordinate2D(latitude: 40.001442, longitude: 116.353915),
//            CLLocationCoordinate2D(latitude: 39.989105, longitude: 116.360200)]
//        self.mapViewContainer.addLineCoordinates(coordinates: lineCoordinates)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension WayBillTransLocationCell {
    
    func showLocation(locations:[ZbnLocation]) {
        let locations = locations.map { (location) -> CLLocationCoordinate2D in
            let coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude ?? 0), longitude: Double(location.longitude ?? 0))
            return coordinate
        }
        self.mapViewContainer.addLineCoordinates(coordinates: locations)
    }
}
