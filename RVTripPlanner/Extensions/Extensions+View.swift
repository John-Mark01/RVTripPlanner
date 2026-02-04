//
//  Extensions+View.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import SwiftUI

extension View {
    //Background
    func applyBackground() -> some View {
        modifier(CustomBackground())
    }
    
    //Keyboard Dismiss
    func dismissesKeyboardOnTap() -> some View {
        modifier(DismissKeyboardOnTap())
    }
    
    //Make Any View a Button
    func renderAsButton(action: @escaping () -> Void, addHaptic: Bool = false) -> some View {
         modifier(MakeViewAButton(action: action, hapticFeedback: addHaptic))
   }
    
    //Add Paddings
    func applyViewPaddings(_ paddings: ViewPaddings) -> some View {
        modifier(CustomViewPaddings(type: paddings))
    }
    
    //Text modifiers
    func applyFont(_ font: Style) -> some View {
        modifier(CustomTextFont(style: font))
    }
        
    func applyTextConfiguration(_ config: TextConfg, descrLabel: String) -> some View {
        modifier(CustomTextConfiguration(config: config, accLabel: descrLabel))
    }
}
