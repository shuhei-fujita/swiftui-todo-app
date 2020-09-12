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
    
    var body: some View {
        VStack {
            HStack {
                TextField("テキストを入力", text: $newItem).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 300)

                Button(action: {
                    self.toDoList.append(self.newItem)
                    self.newItem = ""
                    UserDefaults.standard.set(self.toDoList, forKey: "ToDoList")
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5).frame(width: 50, height: 30)
                        
                        Text("追加").foregroundColor(.white)
                    }
                }
            }
            
            List(toDoList, id: \.self) { item in
                Text(item)
            }
            
            Spacer()
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
