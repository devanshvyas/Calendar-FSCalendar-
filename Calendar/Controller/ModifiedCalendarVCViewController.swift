//
//  ModifiedCalendarVCViewController.swift
//  Calendar
//
//  Created by devansh.vyas on 10/07/18.
//  Copyright © 2018 Solution Analysts. All rights reserved.
//

import UIKit

class ModifiedCalendarVCViewController: UIViewController {

  let obj = ViewController.shared
  
  fileprivate let gregorian = Calendar(identifier: .gregorian)
  
  weak var modifiedCalendar: FSCalendar!
  weak var heightConstrains: NSLayoutConstraint!
  
  override func loadView() {
    obj.data()
    let view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = UIColor.groupTableViewBackground
    self.view = view
    
    let calendar = FSCalendar(frame: CGRect(x: 0, y: 100, width: view.frame.size.width, height: 400))
    calendar.delegate = self
    calendar.dataSource = self
    view.addSubview(calendar)
    self.modifiedCalendar = calendar
    
    modifiedCalendar.register(CustomCalendarCell.self, forCellReuseIdentifier: "cell")
    modifiedCalendar.swipeToChooseGesture.isEnabled = true
    let scopeGesture = UIPanGestureRecognizer(target: modifiedCalendar, action: #selector(modifiedCalendar.handleScopeGesture(_:)));
    modifiedCalendar.addGestureRecognizer(scopeGesture)
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
  }

  

}

extension ModifiedCalendarVCViewController: FSCalendarDelegate,FSCalendarDataSource{
  func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
    view.layoutIfNeeded()
  }
  
  func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
    let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position) as? CustomCalendarCell
    let dateString = obj.dateFormatter.string(from: date)
    var count = 0
    var img: UIImage?
    for i in obj.calendarData{
      if i.date == dateString{
        count = count+1
        img = i.attachments
      }
    }
    if count==2{
      cell?.bloodIcon.image = #imageLiteral(resourceName: "two")
      cell?.bloodIcon.isHidden = false
    }
    else if count == 3{
      cell?.bloodIcon.image = #imageLiteral(resourceName: "three")
      cell?.bloodIcon.isHidden = false
    }
    else if count == 4{
      cell?.bloodIcon.image = #imageLiteral(resourceName: "four")
      cell?.bloodIcon.isHidden = false
    }
    else if count == 4{
      cell?.bloodIcon.image = #imageLiteral(resourceName: "five")
      cell?.bloodIcon.isHidden = false
    }
    else{
      if let image = img{
        cell?.bloodIcon.image = image
        cell?.bloodIcon.isHidden = false
      }
    }
    if count>=1{
      cell?.checkIcon.isHidden = false
    }
    return cell!
  }
  
  
}
