//
//  UITextField+Publisher.swift
//  Queue Managment
//
//  Created by WINTAA on 17.07.22.
//

import Foundation
import Combine
import UIKit

extension UITextField {
  func textPublisher() -> AnyPublisher<String, Never> {
      NotificationCenter.default
          .publisher(for: UITextField.textDidChangeNotification, object: self)
          .map { ($0.object as? UITextField)?.text  ?? "" }
          .eraseToAnyPublisher()
  }
}
