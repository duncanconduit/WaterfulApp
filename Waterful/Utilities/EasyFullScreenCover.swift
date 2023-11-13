//
//  EasyFullScreenCover.swift
//  Waterful
//
//  Created by Duncan Conduit on 27/07/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import SwiftUI

/// A view that presents a full screen cover with an easy dismiss gesture.
struct EasyFullScreenCover<Content: View>: View {
    @Binding var isPresented: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        ZStack {
            content
                .environment(\.easyDismiss, EasyDismiss {
                    isPresented = false
                })
        }
    }
}

extension View {
    /// Presents a full screen cover with an easy dismiss gesture.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the cover.
    ///   - transition: The transition to use when showing or hiding the cover. Defaults to `.opacity`.
    ///   - content: A closure returning the content of the cover.
    /// - Returns: A view that presents a full screen cover with an easy dismiss gesture.
    func easyFullScreenCover<Content>(isPresented: Binding<Bool>, transition: AnyTransition = .opacity, content: @escaping () -> Content) -> some View where Content : View {
        ZStack {
            self
            
            ZStack { // for correct work of transition animation
                if isPresented.wrappedValue {
                    EasyFullScreenCover(isPresented: isPresented, content: content)
                        .transition(transition)
                }
            }
        }
    }
}

/// A type that represents an easy dismiss gesture.
struct EasyDismiss {
    private var action: () -> Void
    
    /// Calls the dismiss action.
    func callAsFunction() {
        action()
    }
    
    /// Creates an easy dismiss gesture.
    /// - Parameter action: The action to perform when dismissing.
    init(action: @escaping () -> Void = { }) {
        self.action = action
    }
}

struct EasyDismissKey: EnvironmentKey {
    static var defaultValue: EasyDismiss = EasyDismiss()
}

extension EnvironmentValues {
    var easyDismiss: EasyDismiss {
        get { self[EasyDismissKey.self] }
        set { self[EasyDismissKey.self] = newValue }
    }
}
