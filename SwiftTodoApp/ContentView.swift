//
//  ContentView.swift
//  SwiftTodoApp
//
//  Created by 藤田修平 on 2020/09/12.
//  Copyright © 2020 syuheifujita. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var newItem: String = ""
    @State var toDoList: [String] = []
    @State var isAlert: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("テキストを入力", text: $newItem).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 300)

                Button(action: {
                    if self.newItem == "" {
                        self.isAlert.toggle()
                    } else {
                        self.toDoList.append(self.newItem)
                        self.newItem = ""
                        UserDefaults.standard.set(self.toDoList, forKey: "ToDoList")
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5).frame(width: 50, height: 30)
                        
                        Text("追加").foregroundColor(.white)
                    }
                }
            }
            
            HStack {
                Spacer()
                EditButton().padding()
            }
            
            List{
                ForEach(toDoList, id: \.self) { item in
                    Text(item)
                }.onDelete { (index) in
                    self.toDoList.remove(atOffsets: index)
                    UserDefaults.standard.set(self.toDoList, forKey: "ToDoList")
                }.onMove { (index, description) in
                    self.toDoList.move(fromOffsets: index, toOffset: description)
                    UserDefaults.standard.set(self.toDoList, forKey: "ToDoList")
                }
            }
            
            Spacer()
            
        }.alert(isPresented: self.$isAlert) {
            Alert(title: Text("テキストを入力してください"), dismissButton: .default(Text("OK")))
        }.onAppear() {
            guard let defaultItem = UserDefaults.standard.array(forKey: "ToDoList") as? [String]
                else{return}
            self.toDoList = defaultItem
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
