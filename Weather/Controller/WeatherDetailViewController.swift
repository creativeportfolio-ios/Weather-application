//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by TechFlitter on 02/11/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var weatherTableView: UITableView!
    var weatherBase: WeatherBase!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Weather Details"
        weatherTableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension WeatherDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell")as! WeatherDetailTableViewCell
        
        cell.nameLabel.text = weatherBase.name
        cell.tempLabel.text = String(format: "%f", (weatherBase.main?.temp!)!)
        cell.humedityLabel.text = String(format: "%d", (weatherBase.main?.humidity!)!)
        cell.tempMinLabel.text = String(format: "%f", (weatherBase.main?.tempMin!)!)
        cell.tempMaxLabel.text = String(format: "%f", (weatherBase.main?.tempMax!)!)
        cell.speedLabel.text = String(format: "%f", (weatherBase.wind?.speed!)!)
        if (weatherBase.weather?.count)! > 0 {
            cell.descLabel.text = weatherBase.weather?[0].descriptionField
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
