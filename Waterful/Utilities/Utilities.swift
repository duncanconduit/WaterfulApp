//
//  Utilities.swift
//  Waterful
//
//  Created by Duncan Conduit on 01/08/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import SwiftUI

/// An extension for the Color struct that allows initialization with a hex string.
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}

/// An extension for the View struct that provides conditional styling and a custom button style.
extension View {
    
    /// Applies a given view modifier to the view if a condition is met.
    /// - Parameters:
    ///   - condition: A boolean value indicating whether the modifier should be applied.
    ///   - apply: A closure that takes the view as an argument and returns the modified view.
    /// - Returns: The original view if the condition is false, otherwise the modified view.
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
    
    /// Applies a shadow to the view.
    /// - Returns: The view with a shadow applied.
    func shadowedStyle() -> some View {
        self
            .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 0)
            .shadow(color: .black.opacity(0.16), radius: 24, x: 0, y: 0)
    }
    
    /// Applies a custom button style to the view.
    /// - Parameters:
    ///   - foreground: The color of the button's text.
    ///   - background: The color of the button's background.
    /// - Returns: The view with the custom button style applied.
    func customButtonStyle(
        foreground: Color = .black,
        background: Color = .white
    ) -> some View {
        self.buttonStyle(
            ExampleButtonStyle(
                foreground: foreground,
                background: background
            )
        )
    }

#if os(iOS)
    /// Applies a corner radius to the view.
    /// - Parameters:
    ///   - radius: The radius of the corners.
    ///   - corners: The corners to apply the radius to.
    /// - Returns: The view with the corner radius applied.
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
#endif
}

/// A private button style used by the customButtonStyle extension.
private struct ExampleButtonStyle: ButtonStyle {
    let foreground: Color
    let background: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.45 : 1)
            .foregroundColor(configuration.isPressed ? foreground.opacity(0.55) : foreground)
            .background(configuration.isPressed ? background.opacity(0.55) : background)
    }
}

#if os(iOS)
/// A private shape used by the cornerRadius extension.
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
#endif

/// A class containing utilities for overriding the display mode.
class Utilities {

    /// The selected appearance mode.
    var selectedAppearance = UserDefaults.standard.integer(forKey: "appearance")
    /// The user interface style.
    var userInterfaceStyle: ColorScheme?

    /// Overrides the display mode based on the selected appearance mode.
    func overrideDisplayMode() {
        var userInterfaceStyle: UIUserInterfaceStyle
        print("Selected Appearance: \(selectedAppearance)")

        if selectedAppearance == 0 {
            userInterfaceStyle = .light
        } else if selectedAppearance == 1 {
            userInterfaceStyle = .dark
        } else {
            userInterfaceStyle = .unspecified
        }
    
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = userInterfaceStyle
        }
    }
}

/// Updates the user interface style based on the selected appearance mode.
func updateUserInterfaceStyle() {
        DispatchQueue.main.async {
            var userInterfaceStyle: UIUserInterfaceStyle
            switch UserDefaults.standard.integer(forKey: "appearance") {
            case 0:
                userInterfaceStyle = .light
            case 1:
                userInterfaceStyle = .dark
            default:
                userInterfaceStyle = .unspecified
            }
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.first?.overrideUserInterfaceStyle = userInterfaceStyle
            }
        }
    }
