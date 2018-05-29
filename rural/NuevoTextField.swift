//
//  NuevoTextField.swift
//  rural
//
//  Created by JOAQUIN DIAZ RAMIREZ on 24/4/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//

import UIKit

class NuevoTextField: UITextField, UITextFieldDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate=self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return false
    }

}
