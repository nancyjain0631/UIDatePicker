//
//  ViewController.swift
//  UIDatePicker
//
//  Created by Nancy Jain on 09/10/22.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var dateTextField: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    dateTextField.delegate = self
  }


}
extension ViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.openDatePicker()
  }
}



//toolbar is inside keyboard

extension ViewController {
  func openDatePicker() {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    datePicker.addTarget(self, action: #selector(self.datePickerHandler(datePicker:)), for: .valueChanged)
    dateTextField.inputView = datePicker  // keyboard
    
//    creating toolbar
    let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelButtonClick))
    let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonClick))
//    flexibleButton will define space, both buttons will be shown equally
    let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    toolbar.setItems([cancelButton, flexibleButton, doneButton], animated: false)
//    field's input will not be taken by keyboard, it'll be taken by this toolbar
    dateTextField.inputAccessoryView = toolbar
  }
  
  @objc
  func cancelButtonClick() {
//    if cancel, hide the keyboard
    dateTextField.resignFirstResponder()
  }
  
  @objc
  func doneButtonClick() {
    if let datePicker = dateTextField.inputView as? UIDatePicker {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .medium
      dateTextField.text = dateFormatter.string(from: datePicker.date)
      print(datePicker.date)
    }
    dateTextField.resignFirstResponder()
  }
  
  @objc
  func datePickerHandler(datePicker: UIDatePicker) {
    print(datePicker.date)
  }
}

