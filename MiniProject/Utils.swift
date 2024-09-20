//
//  Utils.swift
//  MiniProject
//
//  Created by Animesh Singh on 9/19/24.
//

import Foundation

class Utils {
	static func loadStudents() -> [Student] {
		if let data = UserDefaults.standard.data(forKey: "students") {
			if let decodedStudents = try? JSONDecoder().decode([Student].self, from: data) {
				return decodedStudents
			}
		}
		return []
	}
}
