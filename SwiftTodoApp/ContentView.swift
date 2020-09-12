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
    @State var toDoList: [String] = ["apple", "orange", "note"]
    
    var body: some View {
        VStack {
            HStack {
                TextField("テキストを入力", text: $newItem).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: 300)

                Button(action: {
                    self.toDoList.append(self.newItem)
                    self.newItem = ""
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
