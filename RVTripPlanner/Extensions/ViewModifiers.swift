//
//  ViewModifiers.swift
//  RVTripPlanner
//
//  Created by John-Mark Iliev on 4.02.26.
//

import SwiftUI

//Background
struct CustomBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
    }
    
}

//Keyboard Dismissal
struct DismissKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let resign = #selector(UIResponder.resignFirstResponder)
                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
            }
    }
}

//Make Any View a Button
struct MakeViewAButton: ViewModifier {
    var action: () -> Void
    var hapticFeedback: Bool = false
    
    func body(content: Content) -> some View {
        
        Button(action: {
            if hapticFeedback {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            }
            action()
        }) {
            content
        }
    }
}

//Add Paddings
struct CustomViewPaddings: ViewModifier {
    let type: ViewPaddings
    
    private var vValue: CGFloat {
        switch type {
        case .vertical, .all:
            return AppConstants.verticalPadding
        case .horizontal:
            return 0
        case .custom(v: let v, h: _):
            return v
        }
    }
    private var hValue: CGFloat {
        switch type {
        case .vertical:
            return 0
        case .horizontal, .all:
            return AppConstants.horizontalPadding
        case .custom(v: _, h: let h):
            return h
        }
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, vValue)
            .padding(.horizontal, hValue)
    }
}

enum ViewPaddings {
    case vertical
    case horizontal
    case all
    case custom(v: CGFloat, h: CGFloat)
}

//Modifier
struct CustomTextFont: ViewModifier {
    var style: Style
    
    var font: Font {
        switch self.style {
        case .headline:
            return Font.system(.headline, design: .rounded, weight: .semibold)
        case .subheadline:
            return Font.system(.subheadline, design: .rounded, weight: .regular)
        case .title:
            return Font.system(.title3, design: .rounded, weight: .bold)
        case .body:
            return Font.system(.caption2, design: .rounded, weight: .bold)
        }
    }
    
    func body(content: Content) -> some View {
        content
            .font(font)
    }
}

enum Style {
    case headline
    case subheadline
    case title
    case body
}

enum TextConfg {
    case singleLine(TextAlignment)
    case multiline(alignment: TextAlignment, lines: Int?)
}

struct CustomTextConfiguration: ViewModifier {
    let config: TextConfg
    let accLabel: String
    
    private var lineLimit: Int? {
        switch config {
        case .singleLine: return 1
        case let .multiline(_, lines): return lines
        }
    }
    
    private var alignment: TextAlignment {
        switch config {
        case let .singleLine(alignment): return alignment
        case let .multiline(alignment, _): return alignment
        }
    }
    
    func body(content: Content) -> some View {
        content
            .lineLimit(lineLimit)
            .multilineTextAlignment(alignment)
            .accessibilityLabel(Text(accLabel))
    }
}
