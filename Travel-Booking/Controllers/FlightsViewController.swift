//
//  FlightsViewController.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 26/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit

class FlightsViewController: UIViewController, FlightsViewControllerDelegate  {
    
    
    @IBOutlet weak var currentDate: UIButton!
    
    @IBOutlet weak var priceBtn: UIButton!
    
    @IBOutlet weak var fromPlace: UIButton!
    
    @IBOutlet weak var toPlace: UIButton!
    
    @IBOutlet weak var flightsList: UITableView!
    
    @IBOutlet weak var bookingBtn: UIButton!
    
    var flightDetails: FlightQuote?
    
    var sourceId: String?
    var destId: String?
    
    var origin: String?
    var dest: String?
    var selectedDate: String?
    
    var vSpinner : UIView?
    
    private lazy var datePickerToolBar : UIToolbar = {
        let toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        
        toolBar.items = [UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDatePickerDone(sender:)))]
        
        toolBar.sizeToFit()
        return toolBar
    }()
    
    private lazy var datePicker : UIDatePicker = {
        let datePicker = UIDatePicker.init(frame: CGRect.init(x: 0.0, y: datePickerToolBar.frame.origin.y + datePickerToolBar.frame.size.height, width: UIScreen.main.bounds.size.width, height: 250))
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(dateChanged(picker:)), for: .valueChanged)
        datePicker.datePickerMode = .date
        for view in datePicker.subviews {
            view.setValue(UIColor(named: "PrimaryColor"), forKeyPath: "backgroundColor")
            view.setValue(UIColor.white, forKeyPath: "textColor")
        }
        return datePicker
    }()
    
    @objc private func dateChanged(picker : UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: datePicker.date)
        selectedDate = strDate
        
    }
    
    @objc private func onDatePickerDone(sender : UIBarButtonItem) {
        self.currentDate.setTitle(selectedDate, for: .normal)
        self.datePicker.removeFromSuperview()
        self.datePickerToolBar.removeFromSuperview()
    }
    
    @IBAction func bookBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "bookingDone", sender: self)
        
    }
    
    @IBAction func dateBtnClicked(_ sender: Any) {
        self.datePicker.minimumDate = Date()
        self.view .addSubview(self.datePicker)
        self.view .addSubview(self.datePickerToolBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.bookingBtn.isHidden = true
        
        self.flightsList.register(UINib(nibName: "FlightDetailsCell", bundle: nil), forCellReuseIdentifier: "FlightDetailsCell")
        
        self.priceBtn.layer.cornerRadius = 20
        self.bookingBtn.layer.cornerRadius = 30
        
        print(Common.searchedDate())
        selectedDate = Common.searchedDate()
        self.currentDate.setTitle(Common.searchedDate(), for: .normal)
        datePicker.date = Date()
        
        
        origin = "Bengaluru"
        self.sourceId = "BLR-sky"
        
        let sourceAttStr = Common.getAttributedStringForFlights(spacing: 1.0, val1: "From", val2: Common.getIndexedCharsFromString(noOfIndex: 3, value: origin! ), val3: origin! )
        
        fromPlace.setAttributedTitle(sourceAttStr, for: .normal)
        
        let destText = Common.getAttributedStringForFlights(spacing: 1.0, val1: "To", val2: Common.getIndexedCharsFromString(noOfIndex: 3, value: dest ?? "Delhi"), val3: dest ?? "Delhi")
        
        toPlace.setAttributedTitle(destText, for: .normal)
        
        
    }
    
    func getFlights() {
        vSpinner = showSpinner(onView: self.view)

        ServerManager.sharedInstance.getFlightsData(origin: self.sourceId! , dest: self.destId! , date: selectedDate!) { [weak self] (details, error) in
            if let error = error {
                print(error)
            }
            else {
                if let details = details {
                    self?.flightDetails = details
                    self?.flightsList.reloadData()
                    
                    if self?.flightDetails?.quotes?.count == 0 {
                        self?.bookingBtn.isHidden = true
                    }else {
                        self?.bookingBtn.isHidden = false
                    }
                }
            }
            self?.removeSpinner(spinner: self?.vSpinner)
            self?.vSpinner = nil
        }
    }
    
    func findPlaceId(place: String, handler: @escaping (String?) -> Void) {
        ServerManager.sharedInstance.getAirportsData(searchVal: place) { (details, error) in
            if let error = error {
                print(error)
                handler(nil)
            }else {
                if let val = details?.places {
                    if let place = val.filter({$0.placeName == place}).first{
                        handler(place.placeId ?? "")
                    }else{
                        handler(nil)
                    }
                }else{
                    handler(nil)
                }
            }
        }
    }
    
    func saveOriginData(placesObj: AirportsPlaces) {
        origin = placesObj.placeName
        self.sourceId = placesObj.placeId
        
        let sourceAttStr = Common.getAttributedStringForFlights(spacing: 1.0, val1: "From", val2: Common.getIndexedCharsFromString(noOfIndex: 3, value: origin! ), val3: origin! )
        
        fromPlace.setAttributedTitle(sourceAttStr, for: .normal)
        
        if let _ = self.sourceId {
            if let _ = self.destId {
                getFlights()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        findPlaceId(place: dest!) { (placeId) in
            if let _ = placeId {
                self.destId = placeId
                self.getFlights()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "AirportsList" {
                if let airportListVC = segue.destination as? AirportListViewController {
                    
                    airportListVC.delegate = self
                }
            }
        }
    }
    
    
    @IBAction func originPlaceOnClick(_ sender: Any) {
        
        performSegue(withIdentifier: "AirportsList", sender: self)
    }
    
}

extension FlightsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.flightDetails?.quotes?.count) ?? 0
    }
    
    func generateTimer() -> String{
        let formatter: NumberFormatter = {
            let temp = NumberFormatter()
            temp.maximumIntegerDigits = 2
            return temp
        }()
        
        let minutes = formatter.string(from: NSNumber(value: Int.random(in: 1...59)))!
        let hour = Int.random(in: 1...23)
        
        return "\(hour):\(minutes)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightDetailsCell") as? FlightDetailsCell
        cell?.flightChrages.text = "\(self.flightDetails?.currencies?.first?.symbol ?? "") \(self.flightDetails?.quotes?[indexPath.item].minPrice ?? 0)"
        cell?.flightsourceDestLbl.text = "\(Common.getIndexedCharsFromString(noOfIndex: 3, value: self.sourceId!)) - \(Common.getIndexedCharsFromString(noOfIndex: 3, value: self.destId!))"
        cell?.flightTimingTxt.text = "\(generateTimer()) - \(generateTimer())"
        
        cell?.code = self.flightDetails?.carriers?[indexPath.item].name?.readAirlinesJSON()
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118.0
    }
    
}
