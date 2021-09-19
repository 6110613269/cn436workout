//
//  ExerciseView.swift
//  MyWorkOut_Pat
//
//  Created by Natthapat Liawpairoj on 18/9/2564 BE.
//

import SwiftUI
import AVKit

struct ExerciseView: View {
    @AppStorage("rating") private var rating = 0
    @State private var showHistory = false
    @State private var showSuccess = false
    
    @Binding var selectedTab: Int

    let index: Int

    @State private var timerDone = false
    @State private var showTimer = false

    @EnvironmentObject var history: HistoryStore
    @State private var noSort = ""
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(selectedTab: $selectedTab, titleText: Exercise.exercises[index].exerciseName)

                if let url = Bundle.main.url(forResource: Exercise.exercises[index].videoName, withExtension: "mp4") {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: geometry.size.height * 0.45)
                } else {
                    Text("Couldn't find \(Exercise.exercises[index].videoName).mp4")
                        .foregroundColor(.red)
                }
                               
                HStack(spacing: 150) {
                    Button(NSLocalizedString("Start", comment: "begin exercise")) { showTimer.toggle() }
                    
                    Button(NSLocalizedString("Done", comment: "mark as finished")) {
                        history.addDoneExercise(Exercise.exercises[index].exerciseName)
                        timerDone = false
                        showTimer.toggle()

                        if checkDoSort() {
                            showSuccess.toggle()
                        } else {
                            if noSort == "Squat"{
                                selectedTab = 0
                            } else if noSort == "Step Up"{
                                selectedTab = 1
                            } else if noSort == "Burpee"{
                                selectedTab = 2
                            } else if noSort == "Sun Salute"{
                                selectedTab = 3
                            } else if noSort == "Push Up"{
                                selectedTab = 4
                            } else if noSort == "Walking Lunges"{
                                selectedTab = 5
                            } else if noSort == "Crunches"{
                                selectedTab = 6
                            } else {
                                selectedTab += 1
                            }
                        }
                    }
                        
                    .disabled(!timerDone)
                    .sheet(isPresented: $showSuccess) {
                        SuccessView(selectedTab: $selectedTab)
                    }
                }
                .font(.title3)
                .padding()
                
                if showTimer {
                    TimerView(timeDone: $timerDone)
                }
                                
                Spacer()

                RatingView(exerciseIndex: index)
                    .padding()

                Button(NSLocalizedString("History", comment: "view user activity")) { showHistory.toggle() }
                    .padding(.bottom)
                    .sheet(isPresented: $showHistory) {
                        HistoryView(showHistory: $showHistory)
                    }
            }

        }
    }

    
    var lastExercise: Bool {
        index + 1 == Exercise.exercises.count
    }
    
    func checkDoSort() -> Bool {
        let doName = ["Squat", "Step Up", "Burpee", "Sun Salute", "Push Up", "Walking Lunges", "Crunches"]
        var count = 0
        var check = true
        
        for i in 0...doName.count - 1{
            for j in 0...history.exerciseDays[0].exercises.count - 1 {
                if doName[i] != history.exerciseDays[0].exercises[j] {
                    count += 1
                }
                
                if count == history.exerciseDays[0].exercises.count {
                    noSort = doName[i]
                    check = false
                    count = 0
                    return check
                    
                }
            }
            count = 0
        }
        return check
    }}


struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(selectedTab: .constant(1), index: 1)
            .environmentObject(HistoryStore())
    }
}
