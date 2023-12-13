//
//  ContentView.swift
//  VisualizeSorts
//
//  Created by Kimberly Brewer on 12/9/23.
//
// TODO: Add more algorithms (merge, selection, heap, tim sort)
// TODO: Make it work on an iPad (landscape) as well
// TODO: Add Swiftlint
// TODO: Add AppIcon for iPad
// TODO: Can I make the colors all hues of one shade of color // can I give users the options to change the color (color would go light to dark)
// TODO: Can you pop up with a description of what it's doing?
// TODO: Tone generator to get higher and higher pitched as it nears completion
// TODO: look at his book 'Swift Coding Challenges'

import SwiftUI

struct ContentView: View {
    enum SortTypes: String, CaseIterable {
        case bubble = "Bubble Sort"
        case insertion = "Insertion Sort"
        case quick = "Quicksort"
    }
    // give me the range 1-100, then run it through SortValue, return the sorted value, then shuffle the results
    @State private var values = (1...100).map(SortValue.init).shuffled()
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var timerSpeed = 0.1
    @State private var insertionSortPos = 1
    @State private var sortFunction = SortTypes.bubble
    var body: some View {
        VStack(spacing: 20) {
            Text("SortVis")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    ForEach(values) { value in
                        Rectangle()
                            .fill(value.color)
                            .frame(
                                width: proxy.size.width * 0.01,
                                height: proxy.size.height * Double(value.id) / 100
                            )
                    }
                }
            }
            .padding(.bottom)
            Picker("Sort Type", selection: $sortFunction) {
                ForEach(SortTypes.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            HStack(spacing: 20) {
                LabeledContent("Speed") {
                    Slider(value: $timerSpeed, in: 0...1)
                }
                Button("Step", action: step)
                Button("Shuffle") {
                    withAnimation {
                        values.shuffle()
                        insertionSortPos = 1
                    }
                }
            }
            
        }
        .padding()
        .frame(minWidth: 500, minHeight: 400)
        .onReceive(timer) { _ in
            step()
        }
        .onChange(of: timerSpeed) {
            timer.upstream.connect().cancel()
            if timerSpeed != 0 {
                timer = Timer.publish(every: timerSpeed, on: .main, in: .common).autoconnect()
            }
        }
    }
    func step() {
        withAnimation {
            switch sortFunction {
            case .bubble:
                values.bubbleSort()
            case .insertion:
                insertionSortPos = values.insertionSort(startPos: insertionSortPos)
            case .quick:
                values.quickSort()
            }
        }
    }
}

#Preview {
    ContentView()
}
