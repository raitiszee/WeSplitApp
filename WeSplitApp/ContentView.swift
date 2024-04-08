//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Raitis ZE on 08/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmont = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmont / 100 * tipSelection
        let grandTotal = checkAmont + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmont, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))    // Instead of hardcoding value - we assign local value if set, if not then EUR
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                }
            }
             .navigationTitle("WeSplit")
             .toolbar {
                 if amountIsFocused {
                     Button("Done") {
                         amountIsFocused = false
                     }
                 }
             }
        }
        
    }
}

#Preview {
    ContentView()
}
