# 📚 Online Learning ERP App (Flutter + Firebase)

A modern **Online Learning ERP System** built using **Flutter** and **Firebase**, designed to provide a complete digital learning experience for students and administrators.

This project demonstrates how to build a **scalable EdTech platform** with real-time backend, cloud storage, and cross-platform support (Mobile + Web).

---

# 🚀 Project Overview

The **Online Learning ERP App** is a full-stack application that enables:

* 🔐 Secure user authentication  
* 📚 Course and content management  
* 🎥 Video-based learning (YouTube integration)  
* 📝 Assignment submission system (PDF upload)  
* 👨‍🏫 Admin panel for content control  
* 👨‍🎓 Student panel for learning  

---

# 🎯 Objectives

* Build a **mobile + web-based ERP system**
* Provide **centralized learning resources**
* Implement **real-time backend using Firebase**
* Enable **assignment upload & tracking**
* Create a **scalable modular architecture**

---

# 📱 Features

## 👨‍🎓 Student Features

* Login using Firebase Authentication  
* View courses  
* Watch video lectures  
* Access assignments  
* Upload PDF submissions  
* View profile  
* Logout  

---

## 👨‍🏫 Admin Features

* Add courses  
* Add video lectures  
* Create assignments  
* Set due dates  
* Manage content  

---

# 🧱 Technology Stack

| Technology              | Purpose                          |
|------------------------|----------------------------------|
| Flutter                | Cross-platform development       |
| Dart                   | Programming language             |
| Firebase Auth          | Authentication                   |
| Cloud Firestore        | Database                         |
| Firebase Storage       | File storage                     |
| YouTube Player         | Video streaming                  |
| VS Code / PowerShell   | Development tools                |

---

# 📂 Project Structure


lib/
├── app/
│ └── app.dart
│
├── features/
│ ├── admin/
│ ├── auth/
│ ├── courses/
│ ├── assignments/
│ ├── attendance/
│ ├── home/
│ └── profile/
│
├── firebase_options.dart
└── main.dart


---

# ⚙️ Installation Guide

## 1️⃣ Clone Repository

''bash
git clone https://github.com/SiddhantShedge45/OnlineLearning_FlutterAPP.git
cd OnlineLearning_FlutterAPP
2️⃣ Install Dependencies
flutter pub get
3️⃣ Setup Firebase
Install Firebase CLI
npm install -g firebase-tools
Install FlutterFire CLI
dart pub global activate flutterfire_cli
Configure Firebase
flutterfire configure

If path issue:

& "C:\Users\HP\AppData\Local\Pub\Cache\bin\flutterfire.bat" configure
4️⃣ Run Application
flutter run

For Web:

flutter run -d chrome
📦 Dependencies
flutter pub add firebase_core
flutter pub add firebase_auth
flutter pub add cloud_firestore
flutter pub add firebase_storage
flutter pub add file_picker
flutter pub add flutter_launcher_icons
🗂️ Database Design (Firestore)
📚 Courses
courses
 └── courseId
      ├── title
      ├── description
🎥 Videos
courses
 └── courseId
      └── videos
            └── videoId
                  ├── title
                  ├── youtubeUrl
📝 Assignments
courses
 └── courseId
      └── assignments
            └── assignmentId
                  ├── title
                  ├── description
                  ├── dueDate
📄 Submissions
courses
 └── courseId
      └── assignments
            └── assignmentId
                  └── submissions
                        └── userId
                              ├── fileUrl
                              ├── submittedAt
🗄️ Firebase Storage Structure
assignments/
 └── userId/
      └── file.pdf
🔐 Firebase Security Rules
Firestore (Development)
allow read, write: if true;
Firestore (Production)
allow read: if request.auth != null;
Storage Rules
request.auth.uid == userId
🧠 System Workflow
User logs in
Dashboard loads modules
Courses display content
Videos streamed via YouTube
Assignments accessed
Student uploads PDF
File stored in Firebase Storage
URL saved in Firestore
🎨 UI Design Approach
Clean modern layout
Card-based dashboard
Simple navigation
Material UI components
⚠️ Common Errors & Fixes
❌ Permission Denied

➡️ Fix Firestore rules

❌ File Picker Error
flutter clean
flutter pub get
❌ Firebase Not Connecting
flutterfire configure
🔮 Future Enhancements
Role-based authentication
QR-based attendance
Paid course system
Admin analytics dashboard
Chat system
Push notifications
AI-based recommendations
👨‍💻 Author

Siddhant Shedge
Intern Developer – NetGains Technologies Pvt. Ltd.

📄 License

This project is developed for educational purposes only.

⭐ Final Note

This project is a strong foundation for a complete LMS/ERP system.
With further enhancements, it can be transformed into a production-ready SaaS EdTech platform.
