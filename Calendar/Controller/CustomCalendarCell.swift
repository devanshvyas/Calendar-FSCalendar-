//
//  CustomCalendarCell.swift
//  Calendar
//
//  Created by devansh.vyas on 10/07/18.
//  Copyright © 2018 Solution Analysts. All rights reserved.
//

import UIKit


class CustomCalendarCell: FSCalendarCell {
  
  //MARK: VARIABLES
  weak var bloodIcon: UIImageView!
  weak var appointmentIcon: UIImageView!
  weak var checkIcon: UIImageView!

  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let bloodImageView = UIImageView(frame: CGRect(x: contentView.frame.size.width-15, y: contentView.frame.size.height-15, width: 12, height: 12))
    bloodImageView.image = #imageLiteral(resourceName: "blood-drop")
    bloodIcon = bloodImageView
    contentView.addSubview(bloodIcon)
    bloodIcon.isHidden = true
    
    let checkImageView = UIImageView(frame: CGRect(x: 2, y: contentView.frame.size.height-15, width: 12, height: 12))
    checkImageView.image = #imageLiteral(resourceName: "check")
    checkIcon = checkImageView
    contentView.addSubview(checkIcon)
    checkIcon.isHidden = true

    let view = UIView(frame: self.bounds)
    view.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 0.4246575342)
    self.backgroundView = view
  }
  
  required init!(coder aDecoder: NSCoder!) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super .layoutSubviews()
    backgroundView?.frame = self.bounds.insetBy(dx: 1, dy: 1)
  }
  
  override func configureAppearance() {
    super.configureAppearance()
    if self.isPlaceholder {
      self.eventIndicator.isHidden = false
      self.titleLabel.textColor = UIColor.lightGray
    }
  }
  
}
