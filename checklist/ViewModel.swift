//
//  ViewModel.swift
//  checklist
//
//  Created by Andy Huang on 7/30/23.
//

import Foundation

class ViewModel: ObservableObject {
    // TODO: Add class attributes
    @Published var description = ""
    @Published var inProgress: [String] = []
    @Published var complete: [String] = []
    
    func add() -> Void {
        // TODO: Implement
        inProgress.append(description)
        description = ""
        return
    }
    
    func swapToInProgress(task: String) -> Void {
        // TODO: Implement
        if let index = complete.firstIndex(of: task) {
                  complete.remove(at: index)
                  inProgress.append(task)
        }
        return
    }
    
    func swapToComplete(task: String) -> Void {
        // TODO: Implement
        if let index = inProgress.firstIndex(of: task) {
                  inProgress.remove(at: index)
                  complete.append(task)
              }
        return
    }
}
    
