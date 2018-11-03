//
//  ViewController.swift
//  Probate Calculator
//
//  Created by Willie Lassiter on 10/12/18.
//  Copyright © 2018 Willie Lassiter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var property_value: UITextField!
  
  @IBOutlet weak var first_100_000: UnderlineedTextField!
  @IBOutlet weak var second_100_100: UnderlineedTextField!
  @IBOutlet weak var next_800_000: UnderlineedTextField!
  @IBOutlet weak var next_9_000_000: UnderlineedTextField!
  @IBOutlet weak var next_15_000_000: UnderlineedTextField!
  
  @IBOutlet weak var total_fees: UITextField!
  
  func textFieldShouldReturn (_ textField: UITextField) -> Bool {

    textField.resignFirstResponder ()
    self.calculator_clicked (property_value)
    return true
  }
  
  @IBAction func calculator_clicked (_ sender: Any) {
    
    if let text = self.property_value.text {
      
      self.first_100_000.text = ""
      self.first_100_000.isHidden  = false
      self.first_100_000._underline = false
      self.first_100_000.setNeedsDisplay ()

      self.second_100_100.text = ""
      self.second_100_100._underline = false
      self.second_100_100.isHidden  = true
      self.second_100_100.setNeedsDisplay ()

      self.next_800_000.text = ""
      self.next_800_000._underline = false
      self.next_800_000.isHidden  = true
      self.next_800_000.setNeedsDisplay ()

      self.next_9_000_000.text = ""
      self.next_9_000_000._underline = false
      self.next_9_000_000.isHidden  = true
      self.next_9_000_000.setNeedsDisplay ()

      self.next_15_000_000.text = ""
      self.next_15_000_000._underline = false
      self.next_15_000_000.isHidden  = true
      self.next_15_000_000.setNeedsDisplay ()

      
      var filtered = ""
      
      for ch in text {
        
        if ch >= "0" && ch <= "9" || ch == "." {
          filtered.append (ch)
        }
      }

      //
      if var grossValue = Double (filtered) {
        
        let currencyFormatter = NumberFormatter ()
        let decimalFormatter = NumberFormatter ()

        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        decimalFormatter.numberStyle = NumberFormatter.Style.decimal

        var formattedNumber = currencyFormatter.string (from: NSNumber (value:grossValue))

        self.property_value.text = formattedNumber
        
        var fees = 0.0
        
        if grossValue <= 100_000.0 {
          fees = grossValue * 0.04
          formattedNumber = decimalFormatter.string (from: NSNumber (value:fees))

          self.first_100_000.text = formattedNumber
          self.first_100_000._underline = true
          self.first_100_000.isHidden  = false
          self.first_100_000.setNeedsDisplay ()

          self.total_fees.text = currencyFormatter.string (from: NSNumber (value:fees))
          return
        }
        else {
          fees += 100_000.0 * 0.04
          grossValue -= 100_000.0
          self.first_100_000.text = String (format:"%.2f", 100_000.0 * 0.04)
        }
        
        if grossValue <= 100_000.0 {
          fees += grossValue * 0.03
          self.second_100_100.text = String (format:"%.2f", grossValue * 0.03)
          self.second_100_100._underline = true
          self.second_100_100.isHidden  = false
          self.second_100_100.setNeedsDisplay ()

          self.total_fees.text = currencyFormatter.string (from: NSNumber (value:fees))
          return
        }
        else {
          fees += 100_000.0 * 0.03
          grossValue -= 100_000.0
          self.second_100_100.text = String (format:"%.2f", 100_000.0 * 0.03)
          self.second_100_100.isHidden  = false
        }
        
        if grossValue <= 800_000.0 {
          fees += grossValue * 0.02
          self.next_800_000.text = String (format:"%.2f", grossValue * 0.02)
          self.next_800_000._underline = true
          self.next_800_000.isHidden  = false
          self.next_800_000.setNeedsDisplay ()

          self.total_fees.text = currencyFormatter.string (from: NSNumber (value:fees))
          return
        }
        else {
          fees += 800_000.0 * 0.02
          grossValue -= 800_000.0
          self.next_800_000.text = String (format:"%.2f", 800_000.0 * 0.02)
          self.next_800_000.isHidden  = false
        }

        if grossValue <= 9_000_000.0 {
          fees += grossValue * 0.02
          self.next_9_000_000.text = String (format:"%.2f", grossValue * 0.01)
          self.total_fees.text = currencyFormatter.string (from: NSNumber (value:fees))
          return
        }
        else {
          fees += 9_000_000.0 * 0.01
          grossValue -= 9_000_000.0
          self.next_9_000_000.text = String (format:"%.2f", 9_000_000.0 * 0.01)
        }

        if grossValue <= 15_000_000.0 {
          fees += grossValue * 0.005
          self.next_15_000_000.text = String (format:"%.2f", grossValue * 0.005)
          self.total_fees.text = currencyFormatter.string (from: NSNumber (value:fees))
          return
        }
        else {
          fees += 15_000_000.0 * 0.005
          grossValue -= 15_000_000.0
          self.next_15_000_000.text = String (format:"%.2f", 15_000_000.0 * 0.005)
          self.total_fees.text = currencyFormatter.string (from: NSNumber (value:fees))
        }

        self.total_fees.text = "Overflow"
      }
      
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func viewWillAppear (_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    property_value.delegate = self
    property_value.returnKeyType = .done
//    property_value._underline = false

    first_100_000._underline = false
    second_100_100._underline = false
    next_800_000._underline = false
    next_9_000_000._underline = false
    next_15_000_000._underline = false
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func grossPropertyValueField (_ sender: UITextField) {
    
    print ("what happened?")
  }
}



class UnderlineedTextField : UITextField {
  
  var _underline = false

  override var tintColor: UIColor! {
    
    didSet {
      setNeedsDisplay ()
    }
  }
  
  override func draw (_ rect: CGRect) {
    
    if _underline {
      
      let startingPoint   = CGPoint (x: rect.minX, y: rect.maxY)
      let endingPoint     = CGPoint (x: rect.maxX, y: rect.maxY)
      
      let path = UIBezierPath ()
      
      path.move (to: startingPoint)
      path.addLine (to: endingPoint)
      path.lineWidth = 2.0
      
      UIColor.black.setStroke ()
      
      path.stroke ()
    }
  }
}

class UnderlineedLabel : UILabel {

  var _underline = false

  override var tintColor: UIColor! {
    
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func draw (_ rect: CGRect) {
    
    if _underline {
      
      let startingPoint   = CGPoint (x: rect.minX, y: rect.maxY)
      let endingPoint     = CGPoint (x: rect.maxX, y: rect.maxY)
      
      let path = UIBezierPath ()
      
      path.move (to: startingPoint)
      path.addLine (to: endingPoint)
      path.lineWidth = 2.0
      
      tintColor.setStroke ()
      
      path.stroke ()
    }
  }
}

