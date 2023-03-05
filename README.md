## Flutter Simple Chat App
This is a Flutter Simple Chat app that allows users to communicate with each other in real-time. The app utilizes Contact to get user contacts, Firebase Messaging for push notifications, and Cloud Firestore for database storage.

# Features
User authentication and registration.
Get user contacts using Contact plugin.
Real-time messaging using Firebase Messaging.
Store messages in Cloud Firestore.
Push notifications for new messages.
# Installation
Clone the repository to your local machine.
Open the project in your preferred code editor.
Run flutter pub get to install the required packages.
Create a Firebase project and add your own google-services.json file in the android/app directory.
Enable phone number authentication in your Firebase project.
Run flutter run to start the app on your emulator or device.
# Dependencies
cloud_firestore: ^3.1.0
firebase_auth: ^3.1.0
firebase_core: ^1.3.0
firebase_messaging: ^10.0.4
contact_picker: ^0.3.3
fluttertoast: ^8.0.8

# Firebase
This app utilizes Firebase for authentication, database storage, and push notifications. Follow these steps to set up your Firebase project:
Create a new Firebase project in the Firebase console.
Add the Firebase SDK to your app by following the instructions provided by Firebase.
Enable phone number authentication in your Firebase project.
Add a Firebase Firestore database to your project.
Contact Picker
This app uses the contact_picker plugin to get user contacts. The plugin provides a simple way to select contacts from the user's device.

# Firebase Messaging
This app uses Firebase Messaging for real-time messaging and push notifications. Firebase Messaging allows the app to receive notifications when the app is in the background or closed.

# Cloud Firestore
This app uses Cloud Firestore to store messages in real-time. Cloud Firestore is a flexible and scalable database solution that allows the app to store and retrieve data in real-time.

# Conclusion
This Flutter Simple Chat app demonstrates the use of Contact, Firebase Messaging, and Cloud Firestore to create a real-time messaging app. Feel free to modify and customize this app to fit your specific needs. Happy coding!





