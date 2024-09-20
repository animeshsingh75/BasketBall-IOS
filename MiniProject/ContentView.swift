//
//  ContentView.swift
//  MiniProject
//
//  Created by Animesh Singh on 9/19/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		NavigationView {
			MainPageView()
				.navigationBarTitle("Home")
		}
    }
}

#Preview {
    ContentView()
}
