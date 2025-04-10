//
//  ContentView.swift
//  Portfolio
//
//  Created by Sakthikumar on 31/03/25.
//

import SwiftUI

struct HomeView: View {
    @State var animated = false
    @State var thinking = false
    @State var present = false
    @State var viewModel = ViewModel()
    @Environment(\.colorScheme) var colorScheme
    let letters = Array("IOS Developer")
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @Namespace private var animationNamespace
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    ZStack {
                        Rectangle()
                            .fill(.black)
                            .frame(maxWidth: .infinity)
                        
                        Image("profile")
                            .resizable()
                            .frame(maxWidth: 200, maxHeight: 200, alignment: .center)
                            .clipped()
                            .clipShape(Circle())
                            .padding(.top, 30)
                    }
                    
                    VStack(alignment: .center, spacing: 15) {
                        Text("IOS Developer")
                            .font(.system(size: 24, weight: .bold))
                            .phaseAnimator([0.5, 1.0]) { content, phase in
                                content
                                    .opacity(phase)
                                    .scaleEffect(phase)
                                    .animation(.easeInOut(duration: 1.0), value: phase)
                            }
                        
                        Text("""
                     Enthusiastic iOS Developer with 1.9 year of experience in native app development using Swift and SwiftUI. Skilled in version control (GitLab, Bitbucket) and functional user interfaces. Strong understanding of software development principles and a solid foundation in Java. Committed to staying current with evolving mobile technologies.
                     """)
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.leading)
                        
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.skills, id: \.id) {  item in
                                VStack(spacing: 8) {
                                    Image(item.imageName)
                                        .resizable()
                                        .frame(maxWidth: .infinity, maxHeight: 80, alignment: .center)
                                        .cornerRadius(10)
                                    
                                    Text(item.name)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(.primary)
                                }
                                .padding(10)
                                .matchedTransitionSource(id: item.id, in: animationNamespace)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(colorScheme == .dark ? Color.black : Color.white)
                                )
                                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2) , radius: 5)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.selectedSkill = item
                                    withAnimation(.smooth(duration: 0.5)) {
                                        present = true
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LinearGradient(colors: [Color.indigo, Color.black], startPoint: .top, endPoint: .bottom))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    )
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $present, destination: {
                previewView(skill: viewModel.selectedSkill)
                    .navigationTransition(.zoom(sourceID: viewModel.selectedSkill?.id, in: animationNamespace))
            })
        }
    }
}

struct previewView: View {
    var skill: Skill?
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.primary)
            
            VStack {
                if let skill {
                    Image(skill.imageName)
                        .resizable()
                        .frame(maxWidth: 150, maxHeight: 150, alignment: .center)
                        .cornerRadius(10)
                    
                    Text("Version: \(skill.version)")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(skill.description)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading) {
                        ForEach(skill.features, id: \.self) { point in
                            HStack {
                                Circle()
                                    .fill(.red)
                                    .frame(width: 5, height: 5)
                                
                                Text(point)
                                    .font(.system(size: 14))
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }
            }
            .padding(.top, 30)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(LinearGradient(colors: [.indigo, .indigo, .white], startPoint: .top, endPoint: .bottom))
                    .offset(y: 100)
                    .frame(maxHeight: .infinity)
            )
        }
        .navigationTitle(skill?.name ?? "")
    }
}


struct AnimatedGradientView: View {
    @State private var start = UnitPoint(x: 0, y: 0)
    @State private var end = UnitPoint(x: 1, y: 1)
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: start, endPoint: end)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 5).repeatForever(autoreverses: true)) {
                    start = UnitPoint(x: 1, y: 1)
                    end = UnitPoint(x: 0, y: 0)
                }
            }
    }
}


struct AnimatedCirclesView: View {
    @State private var circles = (0..<10).map { _ in CircleData.random() }
    
    var body: some View {
        ZStack {
            ForEach(circles.indices, id: \.self) { index in
                Circle()
                    .fill(circles[index].color)
                    .frame(width: circles[index].size, height: circles[index].size)
                    .position(circles[index].position)
                    .opacity(0.8)
                    .onAppear {
                        animateCircle(index: index)
                    }
            }
        }
        .ignoresSafeArea()
        .background(.black)
    }
    
    func animateCircle(index: Int) {
        withAnimation(Animation.smooth(duration: Double.random(in: 4...7)).repeatForever(autoreverses: true)) {
            circles[index] = CircleData.random()
        }
    }
}

var screenWidth = UIScreen.main.bounds.width

struct CircleData {
    var position: CGPoint
    var size: CGFloat
    var color: Color
    
    
    static func random() -> CircleData {
        CircleData(
            position: CGPoint(x: CGFloat.random(in: 0...screenWidth), y: CGFloat.random(in: 20...150)),
            size: CGFloat.random(in: 25...45),
            color: Color(hue: Double.random(in: 0...1), saturation: 0.7, brightness: 1)
        )
    }
}


struct CurvedProfileBackground: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Start from top left
        path.move(to: CGPoint(x: 0, y: 0))

        // Top edge to left curve start
        path.addLine(to: CGPoint(x: rect.midX - 60, y: 0))

        // Left inward curve
        path.addQuadCurve(to: CGPoint(x: rect.midX - 40, y: 20),
                          control: CGPoint(x: rect.midX - 60, y: 0))

        // Top inner line to right inward curve
        path.addLine(to: CGPoint(x: rect.midX + 40, y: 20))

        // Right inward curve
        path.addQuadCurve(to: CGPoint(x: rect.midX + 60, y: 0),
                          control: CGPoint(x: rect.midX + 60, y: 0))

        // Top edge to top-right
        path.addLine(to: CGPoint(x: rect.width, y: 0))

        // Right side down
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))

        // Bottom edge to bottom-left
        path.addLine(to: CGPoint(x: 0, y: rect.height))

        // Left side up
        path.closeSubpath()

        return path
    }
}



extension Color {
    
    init(hex: String) {
        let trimmedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        // Parse HEX
        let hex = trimmedHex.trimmingCharacters(in: .alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b, a) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
        return
        
    }
}
