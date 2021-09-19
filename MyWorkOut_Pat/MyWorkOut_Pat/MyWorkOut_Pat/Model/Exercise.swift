//
//  Exercise.swift
//  MyWorkOut_Pat
//
//  Created by Natthapat Liawpairoj on 18/9/2564 BE.
//

import Foundation

struct Exercise {
    let exerciseName: String
    let videoName: String

    enum ExerciseEnum: CustomStringConvertible {
        case squat
        case stepUp
        case burpee
        case sunSalute
        case pushUp
        case crunches
        case walkingLunges
    

        var description: String {
            switch self {
                case .squat:
                    return NSLocalizedString("Squat", comment: "exercise")
                case .stepUp:
                    return NSLocalizedString("Step Up", comment: "exercise")
                case .burpee:
                    return NSLocalizedString("Burpee", comment: "exercise")
                case .sunSalute:
                    return NSLocalizedString("Sun Salute", comment: "exercise")
                case .pushUp:
                    return NSLocalizedString("Push Up", comment: "exercise")
                case .walkingLunges:
                    return NSLocalizedString("Walking Lunges", comment: "exercise")
                case .crunches:
                    return NSLocalizedString("Crunches", comment: "exercise")
                    
            }
        }
    }
}


extension Exercise {
    static let exercises = [
        Exercise(exerciseName: String(describing: ExerciseEnum.squat), videoName: "squat"),
        Exercise(exerciseName: String(describing: ExerciseEnum.stepUp), videoName: "stepup"),
        Exercise(exerciseName: String(describing: ExerciseEnum.burpee), videoName: "burpee"),
        Exercise(exerciseName: String(describing: ExerciseEnum.sunSalute), videoName: "sunsalute"),
        Exercise(exerciseName: String(describing: ExerciseEnum.pushUp), videoName: "pushup"),
        Exercise(exerciseName: String(describing: ExerciseEnum.walkingLunges), videoName: "walkinglunges"),
        Exercise(exerciseName: String(describing: ExerciseEnum.crunches), videoName: "crunches")
    ]
}
