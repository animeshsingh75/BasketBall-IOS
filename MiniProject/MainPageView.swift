import SwiftUI

struct MainPageView: View {
	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				Text("Basketball Team Registration")
					.font(.largeTitle)
					.fontWeight(.bold)
					.padding(.top, 50)
				
				Spacer()
				
				// Navigate to View List Page
				NavigationLink(destination: ViewListPage()) {
					Text("View List")
						.frame(minWidth: 0, maxWidth: .infinity)
						.padding()
						.background(Color.blue)
						.foregroundColor(.white)
						.cornerRadius(10)
				}
				
				// Navigate to Add a Student Page
				NavigationLink(destination: AddStudentPage()) {
					Text("Add a Student")
						.frame(minWidth: 0, maxWidth: .infinity)
						.padding()
						.background(Color.green)
						.foregroundColor(.white)
						.cornerRadius(10)
				}
				
				Spacer()
			}
			.padding()
			.navigationBarHidden(true) // Hides the back button on the main page
		}
	}
}
