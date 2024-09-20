import SwiftUI

struct AddStudentPage: View {
	@State private var firstName: String = ""
	@State private var lastName: String = ""
	@State private var asuID: String = ""
	@State private var selectedImage: UIImage? = nil // Change to UIImage to handle Base64 conversion
	@State private var isImagePickerActive = false
	@State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
	
	@State private var showAlert = false
	@State private var alertMessage = ""
	@Environment(\.presentationMode) var presentationMode
	
	var body: some View {
		NavigationStack {
			VStack {
				Text("Add a New Student")
					.font(.largeTitle)
					.fontWeight(.bold)
					.padding(.top, 20)
				
				Form {
					Section(header: Text("Student Information")) {
						TextField("First Name", text: $firstName)
							.keyboardType(.alphabet)
							.autocapitalization(.words)
						TextField("Last Name", text: $lastName)
							.keyboardType(.alphabet)
							.autocapitalization(.words)
						TextField("ASU ID", text: $asuID)
							.keyboardType(.numberPad)
							.onChange(of: asuID) { oldValue, newValue in
								if newValue.count > 10 {
									asuID = String(newValue.prefix(10))
								}
							}
					}
					
					Section(header: Text("Student Picture")) {
						if let image = selectedImage {
							Image(uiImage: image)
								.resizable()
								.frame(width: 100, height: 100)
								.clipShape(Circle())
								.frame(maxWidth: .infinity, alignment: .center)
						} else {
							Text("No image selected")
						}
						
						VStack(spacing: 10) {
							Button(action: {
								if UIImagePickerController.isSourceTypeAvailable(.camera) {
									sourceType = .camera
									isImagePickerActive = true
								}
							}) {
								Text("Open Camera")
									.frame(maxWidth: .infinity)
									.padding()
									.background(Color.blue)
									.foregroundColor(.white)
									.cornerRadius(10)
							}
							HStack {
								VStack{
									Divider()
								}
								Text("or")
								VStack{
									Divider()
								}
							}
							Button(action: {
								sourceType = .photoLibrary
								isImagePickerActive = true
							}) {
								Text("Select from Gallery")
									.frame(maxWidth: .infinity)
									.padding()
									.background(Color.green)
									.foregroundColor(.white)
									.cornerRadius(10)
							}
						}
						.fixedSize(horizontal: false, vertical: true)
					}
				}
				
				Button(action: {
					if firstName.isEmpty || lastName.isEmpty || asuID.isEmpty || selectedImage == nil {
						if selectedImage == nil {
							alertMessage = "Please select an image."
						} else {
							alertMessage = "Please fill in all the required fields."
						}
						showAlert = true
					} else {
						saveStudentData()
						presentationMode.wrappedValue.dismiss()
					}
				}) {
					Text("Save Student")
						.frame(minWidth: 0, maxWidth: .infinity)
						.padding()
						.background(Color.blue)
						.foregroundColor(.white)
						.cornerRadius(10)
				}
				.padding()
				.alert(isPresented: $showAlert) {
					Alert(title: Text("Validation Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
				}
			}
			.padding()
			.navigationDestination(isPresented: $isImagePickerActive) {
				ImagePickerView(selectedImage: $selectedImage, sourceType: sourceType)
			}
		}
	}
	
	private func saveStudentData() {
		let base64ImageString = selectedImage?.jpegData(compressionQuality: 0.8)?.base64EncodedString()
		let student = Student(firstName: firstName, lastName: lastName, asuID: asuID, base64ImageString: base64ImageString)
		var students = Utils.loadStudents()
		students.append(student)
		if let encoded = try? JSONEncoder().encode(students) {
			UserDefaults.standard.set(encoded, forKey: "students")
		}
	}
	
}

struct ImagePickerView: View {
	@Binding var selectedImage: UIImage? // Change to UIImage
	var sourceType: UIImagePickerController.SourceType
	@Environment(\.presentationMode) var presentationMode
	
	var body: some View {
		ImagePicker(selectedImage: $selectedImage, sourceType: sourceType)
			.edgesIgnoringSafeArea(.all)
			.onDisappear {
				presentationMode.wrappedValue.dismiss()
			}
	}
}
