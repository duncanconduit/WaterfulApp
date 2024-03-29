//
//  HomeViewModel.swift
//  Waterful
//
//  Created by Duncan Conduit on 30/06/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import Foundation
import SwiftUI

/// The view model for the home screen of the Waterful app.
final class HomeViewModel: ObservableObject {
    
    /// The properties of the shape used in the view.
    struct ShapeProperties {
        static let size = CGSize(width: 108.31, height: 150.26)
    }
    
    /// The first shape element used in the view.
    struct ShapeElement1: Shape {
        
        private let baseSize: CGSize = ShapeProperties.size
        
        func path(in rect: CGRect) -> Path {
            
            let basePath = Path { path in
                
                let anchorPoints = [
                    CGPoint(x: 54.15, y: 20.98),
                    CGPoint(x: 0, y: 75.13),
                    CGPoint(x: -54.15, y: 20.98),
                    CGPoint(x: 0, y: -75.13),
                    CGPoint(x: 54.15, y: 20.98)
                ]
                
                let control1 = [
                    CGPoint(x: 54.15, y: 50.89),
                    CGPoint(x: -29.91, y: 75.13),
                    CGPoint(x: -54.15, y: -8.93),
                    CGPoint(x: 0, y: -75.13)
                ]
                
                let control2 = [
                    CGPoint(x: 29.91, y: 75.13),
                    CGPoint(x: -54.15, y: 50.89),
                    CGPoint(x: 0, y: -75.13),
                    CGPoint(x: 54.15, y: -8.93)
                ]
                
                path.move(to: anchorPoints[0])
                path.addCurve(to: anchorPoints[1], control1: control1[0], control2: control2[0])
                path.addCurve(to: anchorPoints[2], control1: control1[1], control2: control2[1])
                path.addCurve(to: anchorPoints[3], control1: control1[2], control2: control2[2])
                path.addCurve(to: anchorPoints[4], control1: control1[3], control2: control2[3])
                path.closeSubpath()
                
            }
            
            let rectWidth = rect.size.width
            let rectHeight = rect.size.height
            
            let scaleFactor: CGFloat
            let widthRatio = rectWidth/baseSize.width
            let heightRatio = rectHeight/baseSize.height
            if widthRatio < heightRatio {
                scaleFactor = widthRatio
            } else {
                scaleFactor = heightRatio
            }
            
            let scaleTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            let moveTransform = CGAffineTransform(translationX: 0.5*rectWidth, y: 0.5*rectHeight)
            let combinedTransform = scaleTransform.concatenating(moveTransform)
            
            let modifiedPath = basePath.applying(combinedTransform)
            return modifiedPath
            
        }
    }
    
    /// The action sheet view used in the home screen.
    struct ActionSheetView<Content: View>: View {
        
        let content: Content
        let topPadding: CGFloat
        let fixedHeight: Bool
        let bgColor: Color
        
        init(topPadding: CGFloat = 100, fixedHeight: Bool = false, bgColor: Color = .white, @ViewBuilder content: () -> Content) {
            self.content = content()
            self.topPadding = topPadding
            self.fixedHeight = fixedHeight
            self.bgColor = bgColor
        }
        
        struct CustomCorners: Shape {
            var radius: CGFloat
            var corners: UIRectCorner
            
            func path(in rect: CGRect) -> Path {
                let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
                return Path(path.cgPath)
            }
        }
        
        var body: some View {
            ZStack {
                bgColor.clipShape(CustomCorners(radius: 40, corners: [.topLeft, .topRight]))
                VStack {
                    Color.gray1
                        .opacity(0.9)
                        .frame(width: 30, height: 6)
                        .clipShape(Capsule())
                        .padding(.top, 15)
                        .padding(.bottom, 10)
                    
                    content
                        .padding(.bottom, 30)
                        .applyIf(fixedHeight) {
                            $0.frame(height: UIScreen.main.bounds.height - topPadding)
                        }
                        .applyIf(!fixedHeight) {
                            $0.frame(maxHeight: UIScreen.main.bounds.height - topPadding)
                        }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    /// The first action sheet used in the home screen.
    struct ActionSheetFirst: View {
        var body: some View {
            ActionSheetView(bgColor: .appearance) {
                ScrollView {
                    
                }
            }
        }
    }
    
    /// The calendar button used in the home screen.
    struct CalendarButton: View {
        let date: Date
        let dateFormatter: DateFormatter
        
        init() {
                date = Date()
                dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "LLL"
            }
       
        
        var body: some View {
          
                
        
            ZStack {
                Circle()
                    .strokeBorder(.navTitle, lineWidth: 3.5)
                    .frame(width: 50, height: 50)
                
                VStack {
                    Text(String(Calendar.current.component(.day, from: date)))
                        .scaledToFit()
                        .font(.system(size: 18, design: .rounded))
                        .bold()
                        .foregroundColor(.navTitle)
                    
                    Text(String(dateFormatter.string(from: date)).uppercased())
                        .scaledToFit()
                        .font(.system(size: 11, design: .rounded))
                        .bold()
                        .foregroundColor(.navTitle)
                    
                    
                }
                .frame(width: 40, height: 40)
            }
            
        }
        
    }
    
    
}


#Preview {
    HomeView()
}
