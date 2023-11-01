//
//  HomeView.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//

import SwiftUI
import ConfettiSwiftUI
import PopupView
import SwiftData





struct HomeView: View {
    
    @Environment(\.modelContext) private var context
    @Query(filter: WaterIntake.currentPredicate(),
           sort: \WaterIntake.date
    ) var waterintakes: [WaterIntake]
    @State  var goal = 2000
    @State var showingPopup = false
    @State  var counter: Int = 0
    @State  var ShowSettings = false
    @State var intake: Int = 0
    @State  var isCompleted: Bool = false
    @State var data: WaterIntake!
    @State  var ShowCalendar = false
    @Binding var selectedAppearance: SettingsViewModel.Appearance
    @StateObject  var viewModel = HomeViewModel()
    
    
    
    
    
    
    
    
    
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
                
                Button {
                    
                } label: {
                    Image(systemName: "calendar.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 50,
                            height: 50,
                            alignment: .leading
                        )
                        .padding(.leading, 20)
                        .foregroundColor(Color("Color1"))
                }
                
                
                
                Spacer()
                
                Button {
                    withAnimation {
                        ShowSettings.toggle()
                    }
                    
                } label: {
                    Image(systemName: "gear.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 50,
                            height: 50,
                            alignment: .leading
                        )
                        .padding(.trailing, 20)
                        .foregroundColor(Color("Color1"))
                }
                
                
            }
            
            VStack {
                
                Text(greetingLogic())
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .foregroundStyle(Color("Grad2"))
                    .padding(.bottom, 5)
                
                Text("\(Int(intake))ml of \(Int(goal))ml")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .foregroundStyle(.gray)
                
                
                
                Spacer()
                    .frame(maxHeight: 60)
                
                CircleWaveView(percent: Int(intake/self.goal * 100))
                
                
                Spacer()
                    .frame(maxHeight: 60)
                
                
                CustomButton(buttonTint: Color("Grad2")) {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 40,
                                height: 40
                            )
                    }
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                } action: {
                    intake = intake + 100
                    data.intake = Double(intake)
                    context.insert(data)
                    showingPopup = true
                    counter += 1
                    return .success            }
                .tint(.white)
                .buttonStyle(.opacityLess)
                .confettiCannon(counter: $counter, num: 50, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
                Spacer()
                    .frame(maxHeight: 20)
                Spacer()
                
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                intake = Int(waterintakes.last?.intake ?? 0)
                data = WaterIntake(date: Date(), intake: Double(intake), isCompleted: false)
            }
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
            .easyFullScreenCover(isPresented: $ShowSettings) {
                SettingsView(selectedAppearance: $selectedAppearance)
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
                                .onAppear {
                                    withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                                        self.waveOffset = Angle(degrees: 360)
                                    }
                                }
                            
                        )
                }
            }
            
            .aspectRatio(1, contentMode: .fit)
            
        }
    }
    
}


