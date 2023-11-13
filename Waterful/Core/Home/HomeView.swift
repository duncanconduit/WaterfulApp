//
//  HomeView.swift
//  Waterful
//
//  Created by Duncan Conduit on 25/06/2023.
//  Copyright © 2023 Duncan Conduit. All rights reserved.
//

import SwiftUI
import ConfettiSwiftUI
import PopupView
import SwiftData

/// The main view of the Waterful app, displaying the user's water intake progress and allowing them to add new water intake entries.
struct HomeView: View {
    
    /// The managed object context for the view.
    @Environment(\.modelContext) private var context
    
    /// The color scheme for the view.
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    /// The array of water intake entries.
    @Query(filter: WaterIntake.currentPredicate(),
           sort: \WaterIntake.date
    ) var waterintakes: [WaterIntake]
    
    /// The current water intake amount.
    @State private var intake: Int = 300
    
    /// The daily water intake goal.
    @State private var goal: Int = 2000
    
    /// A boolean indicating whether to show the settings view.
    @State private var ShowSettings = false
    
    /// A boolean indicating whether to show the history view.
    @State private var ShowCalendar = false
    
    /// A boolean indicating whether the daily water intake goal has been reached.
    @State private var isCompleted: Bool = false
    
    /// A boolean indicating whether the add water intake button is in the "end" state.
    @State private var endButton: Bool = false
    
    /// A boolean indicating whether to show the rich popup view.
    @State private var showingPopup = false
    
    /// An integer  indicating whether to show the confetti animation.
    @State private var counter = 0
    
    /// The current water intake entry.
    @State private var data: WaterIntake!
    
    /// The view model for the home view.
    @StateObject  private var viewModel = HomeViewModel()
    
   
    
    /// Determines the appropriate greeting text based on the current time of day.
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
    
    /// The body of the home view.
    var body: some View {
        VStack {
            
            HStack {
                
                Button {
                    withAnimation(.spring()) {
                        ShowCalendar.toggle()
                    }
                } label: {
                    HomeViewModel.CalendarButton()
                        .scaledToFit()
                        .frame(
                            width: 50,
                            height: 50,
                            alignment: .leading
                        )
                        .padding(.leading, 20)
                        
                }
                
                Spacer()
                
                Button {
                    withAnimation() {
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
        .easyFullScreenCover(isPresented: $ShowCalendar) {
            HistoryView()
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
    
    /// A custom shape used to create the wave effect in the `CircleWaveView`.
    struct Wave: Shape {
        
        /// The offset of the wave.
        var offset: Angle
        
        /// The percentage of the wave.
        var percent: Double
        
        /// The animatable data for the wave.
        var animatableData: Double {
            get { offset.degrees }
            set { offset = Angle(degrees: newValue) }
        }
        
        /// The path of the wave.
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
    
    /// A view that displays the user's water intake progress as a circle with a wave effect.
    struct CircleWaveView: View {
        
        /// The offset of the wave.
        @State private var waveOffset = Angle(degrees: 0)
        
        /// The percentage of the wave.
        let percent: Int
        
        /// The body of the circle wave view.
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
