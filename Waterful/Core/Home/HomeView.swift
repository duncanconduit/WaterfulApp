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
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Query(filter: WaterIntake.currentPredicate(),
           sort: \WaterIntake.date
    ) var waterintakes: [WaterIntake]
    @State private var intake: Int = 300
    @State private var goal: Int = 2000
    @State private var showingPopup = false
    @State private var counter: Int = 0
    @State private var ShowSettings = false
    @State private var isCompleted: Bool = false
    @State private var endButton: Bool = false
    @State private var data: WaterIntake!
    @State  private var ShowCalendar = false
    @StateObject  private var viewModel = HomeViewModel()
    
    
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
                        .foregroundColor(.navTitle)
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
                        .foregroundColor(.navTitle)
                }
                
                
            }
            
            VStack {
                
                Text(greetingLogic())
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .foregroundStyle(Color("Grad2"))
                    .padding(.bottom, 5)
                
                Text("\(Int(self.intake))ml of \(Int(self.goal))ml")
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .foregroundStyle(.gray)
                
                
                
                Spacer()
                    .frame(maxHeight: 60)
                
                CircleWaveView(percent: Int(Double(intake)/Double(goal) * 100))
                
                
                
                Spacer()
                    .frame(maxHeight: 60)
                
                
                Button {
                    
                    
                } label: {
                    ZStack {
                        Image(systemName: endButton ? "checkmark.circle.fill" : "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 60,
                                height: 60,
                                alignment: .center
                            )
                            .foregroundStyle(endButton ? .green : .grad2)
                        
                        
                    }
                    .simultaneousGesture(LongPressGesture().onChanged { _ in
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                       
                    })
                    .simultaneousGesture(LongPressGesture().onEnded { _ in
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                        withAnimation(.spring()) {
                            endButton = true
                            intake += 100
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(.spring()) {
                                endButton = false
                            }
                        }
                    })
                    .simultaneousGesture(TapGesture().onEnded {
                        
                    })                    
                }
                .tint(.white)
                .confettiCannon(counter: $counter, num: 50, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
                Spacer()
                    .frame(maxHeight: 20)
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
            
        }
        
        .background(.appearance)
        .easyFullScreenCover(isPresented: $ShowSettings) {
            SettingsView()
        }
        .popup(isPresented: $showingPopup) {
            HomeViewModel.ActionSheetFirst()
        } customize: {
            $0
                .type(.toast)
                .position(.bottom)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.4))
        
      
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
                        .stroke(Color.navTitle, lineWidth: 0.7)
                        .blur(radius: 2)
                        .overlay(
                            Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent)/100)
                                .fill(.white)
                                .clipShape(HomeViewModel.ShapeElement1().scale(1))
                                .onAppear {
                                    withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                                        self.waveOffset = Angle(degrees: 360)
                                    }
                                }
                        )
                        .overlay(
                            Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent)/100)
                                .fill(RadialGradient(gradient: Gradient(colors: [Color(.white), Color(.grad2)]), center: .center, startRadius: 2, endRadius: 250))
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


#Preview {
    HomeView()
}
