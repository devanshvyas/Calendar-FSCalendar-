//
//  ViewController.swift
//  Calendar
//
//  Created by devansh.vyas on 09/07/18.
//  Copyright © 2018 Solution Analysts. All rights reserved.
//

import UIKit
//import FSCalendar

class ViewController: UIViewController,UIGestureRecognizerDelegate{

  @IBOutlet weak var heightConstrains: NSLayoutConstraint!
  @IBOutlet weak var calendarOutlet: FSCalendar!
  @IBOutlet weak var tableViewOutlet: UITableView!
  
  //MARK: variables
  var calendarData = [VisitModel]()
  lazy var panGesture: UIPanGestureRecognizer = {
    [unowned self] in
    let gesture = UIPanGestureRecognizer(target: self.calendarOutlet, action: #selector(self.calendarOutlet.handleScopeGesture(_:)))
    gesture.delegate = self
    gesture.minimumNumberOfTouches = 1
    gesture.maximumNumberOfTouches = 2
    return gesture
    }()
  
  lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yy"
    return formatter
  }()
  
  var selectedDateObj = [VisitModel]()
  var colorDetail = [[String:UIColor]]()
  
  
  //MARK: didLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    tableViewOutlet.dataSource = self
    tableViewOutlet.delegate = self
    data()
    calendarOutlet.addGestureRecognizer(panGesture)
  }
  
  func data() {
    let obj1 = VisitModel()
    obj1.id = 1
    obj1.doctorId = 1
    obj1.patientId = 1
    obj1.eventType = .bloodDonate
    obj1.description = "Blood Donation Time: 11:00 AM"
    obj1.title = "Donate blood at XYZ hospital"
    obj1.date =  "01/07/18"
    obj1.attachments = #imageLiteral(resourceName: "blood-donate")
    obj1.cellColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    calendarData.append(obj1)
    
    let obj2 = VisitModel()
    obj2.id = 2
    obj2.doctorId = 2
    obj2.patientId = 2
    obj2.eventType = .fullBodyCheckUp
    obj2.description = "Body Check Up Time: 11:00 AM"
    obj2.title = "Body Check Up at ABC hospital"
    obj2.date = "14/07/18"
    obj2.attachments = #imageLiteral(resourceName: "appointment")
    obj2.cellColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
    calendarData.append(obj2)
    
    let obj3 = VisitModel()
    obj3.id = 2
    obj3.doctorId = 2
    obj3.patientId = 2
    obj3.eventType = .fullBodyCheckUp
    obj3.description = "Appointment Time: 4:00 PM"
    obj3.title = "Appointment with DR. Pqr"
    obj3.date = "01/07/18"
    obj3.attachments = #imageLiteral(resourceName: "appointment")
    obj3.cellColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    calendarData.append(obj3)
  }
}

extension ViewController: FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance{
  func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
    heightConstrains.constant = bounds.height
    view.layoutIfNeeded()
  }
  
  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    selectedDateObj.removeAll()
    let dateString = dateFormatter.string(from: date)
    if monthPosition == .next || monthPosition == .previous {
      calendar.setCurrentPage(date, animated: true)
    }
    for i in calendarData{
      if i.date == dateString{
        selectedDateObj.append(i)
        self.tableViewOutlet.reloadData()
       }
    }
  }
  
  func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
    let dateString = dateFormatter.string(from: date)
    for i in calendarData{
      if i.date == dateString{
        return i.cellColor
      }
    }
    return nil
  }
  
  func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
    let dateString = dateFormatter.string(from: date)
    var count = 0
    var img: UIImage?
    for i in calendarData{
      if i.date == dateString{
        count = count+1
        img = i.attachments
      }
    }
    if count==2{
      return #imageLiteral(resourceName: "two")
    }
    else if count == 3{
      return #imageLiteral(resourceName: "three")
    }
    else if count == 4{
      return #imageLiteral(resourceName: "four")
    }
    else if count == 4{
      return #imageLiteral(resourceName: "five")
    }
    else{
      if let image = img{
        return image
      }
    }
    return nil
  }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selectedDateObj.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as? DetailTableViewCell
    cell?.title.text = selectedDateObj[indexPath.row].title
    cell?.icon.image = selectedDateObj[indexPath.row].attachments
    return cell!
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let alert = UIAlertController()
    alert.message = selectedDateObj[indexPath.row].description
    let doneAction = UIAlertAction(title: "done", style: .default, handler: nil)
    alert.addAction(doneAction)
    present(alert,animated: true,completion: nil)
  }
}
