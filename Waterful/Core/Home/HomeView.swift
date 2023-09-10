//
//  HomeView.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI



struct HomeView: View {
    
    @State private var percent = 50.0
    @StateObject private var viewModel = HomeViewModel()
    @Binding var showSigninView: Bool
    
    

    
    
    
    func greetingLogic() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        let NEW_DAY = 0
        let NOON = 12
        let SUNSET = 18
        let MIDNIGHT = 24
        
        var greetingText = "Hello" // Default greeting text
        switch hour {
        case NEW_DAY..<NOON:
            greetingText = "Good Morning"
        case NOON..<SUNSET:
            greetingText = "Good Afternoon"
        case SUNSET..<MIDNIGHT:
            greetingText = "Good Evening"
        default:
            _ = "Hello"
        }
        
        return greetingText
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "gearshape.circle")
                    .font(.system(size: 40))
                    .padding()
                
                Spacer()
                
                Text(greetingLogic())
                    .font(.title)
                
                Spacer()
                
                Image(systemName: "person.circle")
                    .font(.system(size: 40))
                    .padding()
                
                
                
            }
            
            //                
            //                HomeViewModel.ShapeElement1()
            //                    .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
            //                    .frame(width: 300, height: 500)
            
            CircleWaveView(percent: Int(self.percent))
            Slider(value: self.$percent, in: 0...100)
                .padding()
            
            Spacer()
                .frame(maxHeight: 10)
            
            Text("\(self.percent)%")
                .font(.title)
            
            Spacer()
                .frame(maxHeight: 20)
            
            Button {
                
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 60))
            }
            
            Spacer()
            
        }
        
    }
}
    
struct Wave: Shape {
    
    var offset: Angle
    var percent: Double
    
    var animatableData: Double {
        get { offset.degrees }
        set { offset = Angle(degrees: newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        // empirically determined values for wave to be seen
        // at 0 and 100 percent
        let lowfudge = 0.02
        let highfudge = 0.98
        
        let newpercent = lowfudge + (highfudge - lowfudge) * percent
        let waveHeight = 0.015 * rect.height
        let yoffset = CGFloat(1 - newpercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 360)
        
        p.move(to: CGPoint(x: 0, y: yoffset + waveHeight * CGFloat(sin(offset.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            p.addLine(to: CGPoint(x: x, y: yoffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        p.closeSubpath()
        
        return p
    }
}


    struct CircleWaveView: View {
        
        @State private var waveOffset = Angle(degrees: 0)
        let percent: Int
        
        var body: some View {

            GeometryReader { geo in
                ZStack {
                    HomeViewModel.ShapeElement1()
                        .stroke(Color.black, lineWidth: 0.7)
                        .overlay(
                            Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent)/100)
                                .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                                .clipShape(HomeViewModel.ShapeElement1().scale(0.99))
                        )
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .onAppear {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
                }
            }
        }
    }

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView(showSigninView: .constant(true))
        }
    }
}
