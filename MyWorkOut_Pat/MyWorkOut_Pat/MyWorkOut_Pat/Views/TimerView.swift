//
//  TimerView.swift
//  MyWorkOut_Pat
//
//  Created by Natthapat Liawpairoj on 18/9/2564 BE.
//

import SwiftUI

struct TimerView: View {
    @State private var timeRemaining = 3
    @Binding var timeDone: Bool
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("\(timeRemaining)")
            .font(.system(size: 90, design: .rounded))
            .padding()
            .onReceive(timer) {_ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timeDone = true
                }
            }

    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(timeDone: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
