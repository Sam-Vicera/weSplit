//
//  ContentView.swift
//  WeSplit
//
//  Created by Samuel Hernandez Vicera on 2/27/24.
//

import SwiftUI



struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool

    
    var tipPercentages = Array(0..<101)
    
    var grandTotal: Double {
    let tipSelection =  Double(tipPercentage) / 100
        
    let tipValue = tipSelection * checkAmount
    let total = checkAmount + tipValue
        return total
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var tipSelected: Bool {
        let tipPercentageSelected = tipPercentage
        
        if tipPercentageSelected == 0 {
            return true
        }
        else {
            return false
        }
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Tip Percentage"){
                    
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id:\.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                }
                
                Section("Grand Total"){
                    Text(grandTotal, format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipSelected ? .red : .black)
                }
                
                Section("Amount Per Person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                       
                }
                
            }
            .navigationTitle("weSplit")
            .toolbar(){
                if amountIsFocused {
                    Button("Done"){
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

