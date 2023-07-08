//
//  HomeViewModel.swift
//  Waterful
//
//  Created by Duncan Conduit on 30/06/2023.
//

import Foundation
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    
    struct ShapeProperties {
        static let size = CGSize(width: 108.31, height: 150.26)
    }
    
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
    
    
}



