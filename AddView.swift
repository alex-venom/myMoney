//
//  AddView.swift
//  AddView
//
//  Created by ITFamily on 30.11.21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses:Expenses
    
    @State private var name = ""
    @State private var type = "Доходы"
    @State private var currency = "BYN"
    @State private var amount = ""
    
    let types = ["Доходы", "Расходы"]
    let currencies = ["BYN", "USD"]
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Название", text: $name)
                Picker("Тип", selection: $type) {
                    ForEach(self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Стоимость", text: $amount)
                    .keyboardType(.numberPad)
                Picker("Валюта", selection: $currency) {
                    ForEach(self.currencies, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationBarTitle("Добавить")
            .navigationBarItems(trailing: Button("Сохранить") {
                if let actualAmount = Int(self.amount){
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount, currency: self.currency)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
