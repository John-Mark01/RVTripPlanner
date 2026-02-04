//
//  CustomTextField.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import SwiftUI

struct CustomTextField: View {
    @FocusState var isFocused: Bool
    @Binding var input: String
    var title: any StringProtocol = ""
    var prompt: any StringProtocol
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField(title, text: $input, prompt: Text(prompt))
            .focused($isFocused)
            .onTapGesture { isFocused = true }
            .keyboardType(keyboardType)
            .autocorrectionDisabled()
    }
}
