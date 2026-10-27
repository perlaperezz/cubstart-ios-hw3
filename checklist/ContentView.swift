//
//  ContentView.swift
//  checklist
//
//  Created by Andy Huang on 7/16/23.
//

import SwiftUI

struct ContentView: View {
    //@State lets Swift update the view when it changes
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(
                description: $viewModel.description,
                inProgress: $viewModel.inProgress,
                addTask: {
                    viewModel.add()
                }
            )

            // Your checklist will go here.
            ChecklistView(
                inProgress: $viewModel.inProgress,
                complete: $viewModel.complete,
                swapToInProgress: { task in
                    viewModel.swapToInProgress(task: task)
                },
                swapToComplete: { task in
                    viewModel.swapToComplete(task: task)
                }
            )

            Spacer()
        }
        .padding()
        .padding(.top, 20)
    }
}

struct HeaderView: View {
    //@Binding allows you to edit the value even if stored elsewhere
    @Binding var description: String
    @Binding var inProgress: [String]
    var addTask: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            //profile picture and name
            HStack {
                Image("chihuahua")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                
                Text("Perla and Melissa")
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            
            //textbox and add button
            HStack(spacing: 10) {
                TextField("Enter description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    addTask()
                }) {
                    Text("Add")
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 20)
                        )
                    }
            }
            .padding(.top, 10)
        }
    }
}

struct ChecklistView: View {
    @Binding var inProgress: [String]
    @Binding var complete: [String]
    var swapToInProgress: (String) -> Void
    var swapToComplete: (String) -> Void

    var body: some View {
        List {
            Section(header:
                Text("In progress")
                    .textCase(nil)
            ) {
                ForEach(inProgress.indices, id: \.self) { index in
                    Button(action: {
                        swapToComplete(inProgress[index])
                    }) {
                        HStack {
                            Image(systemName: "circle")
                            Text(inProgress[index])
                        }
                        .foregroundColor(.primary)
                    }
                }
            }

            Section(header:
                Text("Complete")
                    .textCase(nil)
            ) {
                ForEach(complete.indices, id: \.self) { index in
                    Button(action: {
                        swapToInProgress(complete[index])
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text(complete[index])
                        }
                        .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
