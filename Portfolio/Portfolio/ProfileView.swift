//
//  ProfileView.swift
//  Portfolio
//
//  Created by Sakthikumar on 09/04/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var displayText = ""
    let text = "IOS DEVELOPER"
    @State var viewModel = ViewModel()
    @State var skills: Skill?
    @State private var lineProgress: [CGFloat] = Array(repeating: 0, count: 2)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(.primary)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 15) {
                        Text(displayText)
                            .font(.customBoldItalic(size: 25))
                            .foregroundStyle(.indigo)
                            .onAppear {
                                displayText = ""
                                for (index, char) in text.enumerated() {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.08) {
                                        displayText.append(char)
                                    }
                                }
                            }
                            .onDisappear {
                                displayText = ""
                            }
                        
                        Image("profile")
                            .resizable()
                            .frame(width: 230, height: 230)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.white)
                                    .shadow(radius: 5)
                            )
                        
                        Text("Vigneshvaran")
                            .font(.customBold(size: 30))
                        
                        
                        Text("Professional Summary")
                            .font(.customBold(size: 22))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("""
             Enthusiastic iOS Developer with 1.9 year of experience in native app development using Swift and SwiftUI. Skilled in version control (GitLab, Bitbucket) and functional user interfaces. Strong understanding of software development principles and a solid foundation in Java.
             """)
                        .font(.customRegular(size: 20))
                        
                        Text("Skill - \(skills?.name ?? "")")
                            .font(.customBold(size: 22))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 10) {
                                ForEach(viewModel.skills, id: \.id) { skill in
                                    Image(skill.imageName)
                                        .resizable()
                                        .frame(width: 150, height: 150)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .id(skill)
                                        .padding(8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(.white)
                                        )
                                        .scrollTransition(topLeading: .interactive, bottomTrailing: .interactive, axis: .horizontal, transition: { content, phase in
                                            content
                                                .scaleEffect(1 - abs(phase.value))
                                                .opacity(1 - abs(phase.value))
                                        })
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .safeAreaPadding(.horizontal, 60)
                        .scrollClipDisabled()
                        .scrollPosition(id: $skills)
                        .scrollTargetBehavior(.viewAligned)
                        .onAppear {
                            skills = viewModel.skills.first
                        }
                        
                        Text("Education")
                            .font(.customBold(size: 22))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 10) {
                            ForEach(Array(viewModel.education.enumerated()), id: \.element.id) { index, education in
                                if education.isVisible {
                                    HStack(alignment: .top, spacing: 10) {
                                        VStack(spacing: 1) {
                                            Image(systemName: "checkmark")
                                                .resizable().frame(width: 10, height: 10)
                                                .foregroundStyle(.white)
                                                .padding(5)
                                                .background(
                                                    Circle()
                                                        .fill(.green)
                                                )
                                            
                                            if index != 2 {
                                                AnimatedDottedLine(progress: lineProgress[index])
                                                    .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round))
                                                    .frame(width: 1, height: 50)
                                            }
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(education.qualification)
                                                .font(.customRegular(size: 18))
                                           
                                            Text(education.place)
                                                .font(.customRegular(size: 15))
                                            
                                            Text(education.duration)
                                                .font(.customRegular(size: 13))
                                        }
                                        
                                        Spacer()
                                    }
                                    .transition(.opacity.combined(with: .move(edge: .trailing)))
                                    .animation(.easeOut(duration: 0.4), value: education.isVisible)
                                }
                            }
                        }
                        .onAppear {
                            for i in 0..<viewModel.education.count {
                                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.4) {
                                    withAnimation(.easeOut(duration: 0.8).delay(Double(i) * 0.5)) {
                                        viewModel.education[i].isVisible = true
                                    }
                                    
                                    if i < viewModel.education.count - 1 {
                                        withAnimation(.easeInOut(duration: 0.5).delay(1)) {
                                            lineProgress[i] = 1.0
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(LinearGradient(colors: [.indigo, .white], startPoint: .top, endPoint: .bottom))
                            .offset(y: 200)
                    }
                }
            }
            .padding(.vertical)
            .background(
                Color.white
            )
        }
    }
}

extension Font {
    static func customBold(size: CGFloat) -> Font {
        return Font.custom("BalsamiqSans-Bold", size: size)
    }
    
    static func customBoldItalic(size: CGFloat) -> Font {
        return Font.custom("BalsamiqSans-BoldItalic", size: size)
    }
    
    static func customRegular(size: CGFloat) -> Font {
        return Font.custom("BalsamiqSans-Regular", size: size)
    }
}


struct AnimatedDottedLine: Shape {
    var progress: CGFloat

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let dashHeight: CGFloat = 5
        let dashSpacing: CGFloat = 2
        var y: CGFloat = 0

        while y < rect.height * progress {
            path.move(to: CGPoint(x: rect.midX, y: y))
            path.addLine(to: CGPoint(x: rect.midX, y: min(y + dashHeight, rect.height)))
            y += dashHeight + dashSpacing
        }

        return path
    }
}
