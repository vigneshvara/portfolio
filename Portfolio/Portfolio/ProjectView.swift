//
//  ProjectView.swift
//  Portfolio
//
//  Created by Sakthikumar on 09/04/25.
//

import SwiftUI

struct ProjectView: View {
    @State var viewModel = ViewModel()
    @State var project: Project?
    @State var image: String?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15) {
                HStack {
                    Image(systemName: "chevron.left.2")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(10)
                        .foregroundStyle(.white)
                        .background(
                            Circle()
                                .fill(.indigo)
                        )
                        .offset(y: -25)
                        .opacity(project?.id == (viewModel.projects.first?.id ?? "") ? 0.5 : 1.0)
                        .onTapGesture {
                            if let project, let index = viewModel.projects.firstIndex(of: project), index > 0  {
                                withAnimation(.spring(duration: 0.5, bounce: 0.5, blendDuration: 1.0)) {
                                    self.project = viewModel.projects[index - 1]
                                }
                            }
                        }
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.projects, id: \.id) { project in
                                Image(project.applogo)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .cornerRadius(10)
                                    .containerRelativeFrame(.horizontal, alignment: .center)
                                    .scrollTransition(topLeading: .interactive, bottomTrailing: .interactive, transition: { view , phase in
                                        view
                                            .rotation3DEffect(.degrees(phase.value * 90), axis: (1 , 0, 3))
                                            .offset(y: abs(phase.value) * 80)
                                    })
                                    .shadow(radius: 5, x: 5, y: 5)
                                    .id(project)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollClipDisabled()
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $project)
                    .scrollIndicators(.hidden)
                    
                    Image(systemName: "chevron.right.2")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(10)
                        .foregroundStyle(.white)
                        .background(
                            Circle()
                                .fill(.indigo)
                        )
                        .offset(y: -25)
                        .opacity(project?.id == (viewModel.projects.last?.id ?? "") ? 0.5 : 1.0)
                        .onTapGesture {
                            if let project, let index = viewModel.projects.firstIndex(of: project), index < viewModel.projects.count - 1  {
                                withAnimation(.spring(duration: 0.5, bounce: 0.5, blendDuration: 1.0)) {
                                    self.project = viewModel.projects[index + 1]
                                }
                            }
                        }
                }
                
                Text(project?.name ?? "")
                    .font(.customBold(size: 25))
                    .multilineTextAlignment(.center)
                
                Text(project?.description ?? "")
                .multilineTextAlignment(.leading)
                .font(.customRegular(size: 16))
                
                Text("Tech Stack")
                    .font(.customBoldItalic(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach((project?.techUsed ?? []), id: \.self) { item in
                    Text(item)
                        .font(.customBold(size: 16))
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.indigo.opacity(0.5))
                        )
                }
                
                Text("Image Overview")
                    .font(.customBoldItalic(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach((project?.images ?? []), id: \.self) { name in
                            Image(name)
                                .resizable()
                                .scaledToFit()
                                .id(name)
                                .frame(maxWidth: .infinity, maxHeight: 500)
                                .scrollTransition(topLeading: .animated, bottomTrailing: .animated, transition: { view, phase in
                                    view
                                        .scaleEffect(1 - abs(phase.value))
                                        .rotation3DEffect(.degrees(phase.value * 90), axis: (0, 1, 0))
                                })
                                .containerRelativeFrame(.horizontal)
                                .shadow(color: .black, radius: 5, x: 5, y: 5)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollClipDisabled()
                .safeAreaPadding(.vertical)
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $image)
                .onAppear {
                    image = project?.images.first
                }
                
                HStack {
                    ForEach((project?.images ?? []), id: \.self) { name in
                        Circle()
                            .fill(name == image ? .indigo : .gray)
                            .scaleEffect(name == image ? 1.5 : 1)
                            .frame(width: 5, height: 5)
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [.indigo, .white.opacity(0.8)], startPoint: .top, endPoint: .bottom))
                    .offset(y: 75)
            }
            .onAppear {
                project = viewModel.projects.first
            }
            .onChange(of: project) {
                image = project?.images.first
            }
        }
        .padding(.vertical)
        .background(
            Color.white
        )
    }
}

#Preview {
    ProjectView()
}
