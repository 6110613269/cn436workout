//
//  MyWorkOut_PatApp.swift
//  MyWorkOut_Pat
//
//  Created by Natthapat Liawpairoj on 18/9/2564 BE.
//

import SwiftUI

@main
struct MyWorkout_PatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
                }
                .environmentObject(HistoryStore())
        }
    }
}
