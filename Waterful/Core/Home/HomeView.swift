//
//  HomeView.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI
import PopupView


struct HomeView: View {
    
   
    @State private var mils = 500.0
    @State private var goal = 1800.0
    @State var showingPopup = false
   
   
   
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
                
            CircleWaveView(percent: Int(self.mils/self.goal * 100))
            
            
            Spacer()
                .frame(maxHeight: 20)
            
            Text("\(Int(self.mils))ml of \(Int(self.goal))ml")
                .font(.title)
            
            Spacer()
                .frame(maxHeight: 20)
            
            CustomButton(buttonTint: .blue) {
                HStack(spacing: 10) {
                    Image(systemName: "plus")
                }
                .fontWeight(.bold)
                .foregroundStyle(.white)
            } action: {
                mils = mils + 100
                showingPopup = true
                return .success
            }
            .tint(.white)
            .buttonStyle(.opacityLess)
            
            Spacer()
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(RadialGradient(gradient: Gradient(colors: [Color("Grad1"), Color("Grad2")]), center: .center, startRadius: 2, endRadius: 650)
        )
        .popup(isPresented: $showingPopup) { // 3
                   ZStack { // 4
                       Color.blue.frame(width: 200, height: 100)
                       Text("Popup!")
                   }
               } customize: {
                   $0
                       .type (.toast)
                       .position(.bottom)
                       .dragToDismiss(true)
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
                        .blur(radius: 2)
                        .overlay(
                            Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent)/100)
                                .fill(RadialGradient(gradient: Gradient(colors: [Color(.white), Color("Droplet1")]), center: .center, startRadius: 2, endRadius: 250))
                                .clipShape(HomeViewModel.ShapeElement1().scale(1))
                                
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

private struct ActivityView: View {
    let emoji: String
    let name: String
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 12) {
            Text(emoji)
                .font(.system(size: 24))
            
            Text(name.uppercased())
                .font(.system(size: 13, weight: isSelected ? .regular : .light))
            
            Spacer()
            
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(Color("9265F8"))
            }
        }
        .opacity(isSelected ? 1.0 : 0.8)
    }
}


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

    var body: some View {
        ZStack {
            bgColor.cornerRadius(40)
            VStack {
                Color.black
                    .opacity(0.2)
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


struct ActionSheetFirst: View {
    var body: some View {
        ActionSheetView(bgColor: .white) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ActivityView(emoji: "🤼‍♂️", name: "Sparring", isSelected: true)
                    ActivityView(emoji: "🧘", name: "Yoga", isSelected: false)
                    ActivityView(emoji: "🚴", name: "cycling", isSelected: false)
                    ActivityView(emoji: "🏊", name: "Swimming", isSelected: false)
                    ActivityView(emoji: "🏄", name: "Surfing", isSelected: false)
                    ActivityView(emoji: "🤸", name: "Fitness", isSelected: false)
                    ActivityView(emoji: "⛹️", name: "Basketball", isSelected: true)
                    ActivityView(emoji: "🏋️", name: "Lifting Weights", isSelected: false)
                    ActivityView(emoji: "⚽️", name: "Football", isSelected: false)
                }
                .padding(.horizontal, 20)
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
