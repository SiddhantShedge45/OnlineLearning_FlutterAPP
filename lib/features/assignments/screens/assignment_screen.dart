import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  Future<void> uploadPDF(
      BuildContext context, String courseId, String assignmentId) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      // 🔥 FILE PICKER (FIXED)
      final result = await FilePicker.platform.pickFiles(
        withData: true, // IMPORTANT for web
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) return;

      final file = result.files.first;

      if (file.bytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to read file")),
        );
        return;
      }

      // 🔥 UPLOAD TO FIREBASE STORAGE
      final ref = FirebaseStorage.instance
          .ref()
          .child('assignments/${user!.uid}/${file.name}');

      await ref.putData(file.bytes!);

      final url = await ref.getDownloadURL();

      // 🔥 SAVE IN FIRESTORE
      await FirebaseFirestore.instance
          .collection('courses')
          .doc(courseId)
          .collection('assignments')
          .doc(assignmentId)
          .collection('submissions')
          .doc(user.uid)
          .set({
        'fileUrl': url,
        'submittedAt': DateTime.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Assignment Uploaded ✅")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assignments")),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collectionGroup('assignments')
            .snapshots(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("No Assignments Found"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {

              final data = docs[index];

              // 🔥 SAFE DUE DATE
              DateTime? due;
              if (data.data().containsKey('dueDate') &&
                  data['dueDate'] != null) {
                due = (data['dueDate'] as Timestamp).toDate();
              }

              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,

                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),

                  title: Text(
                    data['title'] ?? "No Title",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(data['description'] ?? ""),
                      const SizedBox(height: 5),

                      if (due != null)
                        Text(
                          "Due: ${due.toLocal()}".split(' ')[0],
                          style: const TextStyle(color: Colors.red),
                        ),
                    ],
                  ),

                  trailing: ElevatedButton(
                    onPressed: () {
                      uploadPDF(
                        context,
                        data.reference.parent.parent!.id,
                        data.id,
                      );
                    },
                    child: const Text("Upload"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}