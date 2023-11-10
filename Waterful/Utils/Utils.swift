//
//  Utils.swift
//  Waterful
//
//  Created by Duncan Conduit on 01/11/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import SwiftUI

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

extension View {
    
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
    
    func shadowedStyle() -> some View {
        self
            .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 0)
            .shadow(color: .black.opacity(0.16), radius: 24, x: 0, y: 0)
    }
    
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
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
#endif
}

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
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
#endif

class Utilities {

    var selectedAppearance = UserDefaults.standard.integer(forKey: "appearance")
    var userInterfaceStyle: ColorScheme?

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
