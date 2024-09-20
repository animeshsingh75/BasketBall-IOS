//
//  Student.swift
//  MiniProject
//
//  Created by Animesh Singh on 9/19/24.
//

import Foundation
import SwiftUICore
import SwiftUI

import SwiftUI

struct ViewListPage: View {
	@State private var students: [Student] = []
	
	var body: some View {
		NavigationStack {
			if students.isEmpty {
				Text("No students registered yet.")
					.font(.headline)
					.padding()
			} else {
				List(students, id: \.asuID) { student in
					HStack {
						if let image = decodeBase64ToUIImage(base64String: student.base64ImageString) {
							Image(uiImage: image)
								.resizable()
								.frame(width: 50, height: 50)
								.clipShape(Circle())
						} else {
							Image(systemName: "person.crop.circle.fill")
								.resizable()
								.frame(width: 50, height: 50)
								.clipShape(Circle())
						}
						
						VStack(alignment: .leading) {
							Text("\(student.firstName) \(student.lastName)")
								.font(.headline)
							Text("ASU ID: \(student.asuID)")
								.font(.subheadline)
						}
					}
					.padding(.vertical, 10)
				}
				.navigationTitle("Registered Students")
			}
		}
		.onAppear {
			students = Utils.loadStudents()
		}
	}
	
	private func decodeBase64ToUIImage(base64String: String?) -> UIImage? {
		guard let base64String = base64String,
			  let imageData = Data(base64Encoded: base64String),
			  let uiImage = UIImage(data: imageData) else {
			return nil
		}
		return uiImage
	}
}
