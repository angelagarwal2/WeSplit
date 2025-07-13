//
//  ContentView.swift
//  WeSplit
//
//  Created by Angel on 01/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount=0.0
    @State private var numberOfPeople=2
    @State private var tipPercentage=20
    @FocusState private var amountIsFocused:Bool
    let tipPercentages=[10,15,20,25,0]
    
    var total:Double{
        let tipSelection=Double(tipPercentage)
        let tipValue=checkAmount/100*tipSelection
        let grandTotal=checkAmount+tipValue
        return grandTotal
    }
    var totalPerPerson:Double{
        //calculates the total per person here
        let peopleCount=Double(2+numberOfPeople)
        let tipSelection=Double(tipPercentage)
        let tipValue=checkAmount/100*tipSelection
        let grandTotal=checkAmount+tipValue
        let AmountPerPerson=grandTotal/peopleCount
        return AmountPerPerson
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount",value:$checkAmount,format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people",selection:$numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip Percentage",selection:$tipPercentage){
                        ForEach(tipPercentages,id:\.self){
                            Text($0,format:.percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total Amount")
                {
                    Text(total,format:.currency(code:Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Amount Per Person"){
                    Text(totalPerPerson,format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
                .navigationTitle("WeSplit")
                .toolbar{
                    if amountIsFocused
                    {
                        Button("Done"){
                            amountIsFocused=false
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
