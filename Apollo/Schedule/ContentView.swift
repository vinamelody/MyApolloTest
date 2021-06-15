//
//  ContentView.swift
//  Apollo
//
//  Created by Vina Melody on 12/6/21.
//

import SwiftUI
import Apollo

struct ContentView: View {
    
    @State private var schedule: [GetScheduleSubscription.Data.Schedule] = []
    
    var body: some View {
        NavigationView {
            Text("Pane")
        }
        .navigationTitle("Hello")
        .onAppear(perform: {
            NetworkManager.shared.client?.subscribe(subscription: GetScheduleSubscription(), resultHandler: { result in
                switch result {
                case .success(let response):
                    if let schedule = response.data?.schedule {
                        self.schedule = schedule
                    }
                case .failure(let error):
                    print("error \(error)")
                }
                
            })
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
