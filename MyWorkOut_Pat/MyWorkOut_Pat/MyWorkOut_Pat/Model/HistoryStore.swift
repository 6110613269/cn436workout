//
//  HistoryStore.swift
//  MyWorkOut_Pat
//
//  Created by Natthapat Liawpairoj on 18/9/2564 BE.
//

import Foundation

struct ExerciseDay: Identifiable {
    let id = UUID()
    let date: Date
    var exercises: [String] = []
}

class HistoryStore: ObservableObject {
    @Published var exerciseDays: [ExerciseDay] = []
    
    init() {
        #if DEBUG
        createDevData()
        #endif

        load()
        
    }

    func addDoneExercise(_ exerciseName: String) {
        let today = Date()
        var checkSame = false
        if let firstDate = exerciseDays.first?.date, today.isSameDay(as: firstDate) {
            for i in 0...exerciseDays[0].exercises.count - 1 {
                if exerciseDays.first?.exercises[i] != exerciseName {
                    checkSame = true
                } else {
                    checkSame = false
                    break
                }
            }
            if checkSame == true {
                exerciseDays[0].exercises.append(exerciseName)
            }
        } else {
            exerciseDays.insert(
                ExerciseDay(date: today, exercises: [exerciseName]), at: 0)
        }

        save()
    }

    func load() {
        guard let dataURL = getURL() else {
            print("Can't get file url.")
            return
        }

        do {
            let data = try Data(contentsOf: dataURL)
            let plistData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
            let convertedPlistData = plistData as? [[Any]] ?? []
            exerciseDays = convertedPlistData.map {
                ExerciseDay(date: $0[1] as? Date ?? Date(), exercises: $0[2] as? [String] ?? [])
            }
        } catch {
            print("Error loading file.")
        }

    }

    func save() {
        guard let dataURL = getURL() else {
            print("Can't get file url.")
            return
        }

        let plistData = exerciseDays.map { [$0.id.uuidString, $0.date, $0.exercises] }

        do {
            let data = try PropertyListSerialization.data(fromPropertyList: plistData, format: .binary, options: .zero)
            try data.write(to: dataURL, options: .atomic)
        } catch {
            print("Can't save file.")
        }
    }

    func getURL() -> URL? {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask).first else {
                return nil
        }
        return documentsURL.appendingPathComponent("history.plist")
    }
    
   
}
