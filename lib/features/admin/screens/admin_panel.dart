import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {

  // CONTROLLERS
  final courseTitle = TextEditingController();
  final courseDesc = TextEditingController();

  final videoTitle = TextEditingController();
  final videoUrl = TextEditingController();

  final assignmentTitle = TextEditingController();
  final assignmentDesc = TextEditingController();

  String? selectedCourseId;
  DateTime? selectedDate;

  // COMMON INPUT STYLE
  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }

  // ADD COURSE
  void addCourse() async {
    if (courseTitle.text.isEmpty || courseDesc.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('courses').add({
      'title': courseTitle.text.trim(),
      'description': courseDesc.text.trim(),
    });

    courseTitle.clear();
    courseDesc.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Course Added")));
  }

  // ADD VIDEO
  void addVideo() async {
    if (selectedCourseId == null ||
        videoTitle.text.isEmpty ||
        videoUrl.text.isEmpty) return;

    await FirebaseFirestore.instance
        .collection('courses')
        .doc(selectedCourseId)
        .collection('videos')
        .add({
      'title': videoTitle.text.trim(),
      'youtubeUrl': videoUrl.text.trim(),
    });

    videoTitle.clear();
    videoUrl.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Video Added")));
  }

  // ADD ASSIGNMENT
  void addAssignment() async {
    if (selectedCourseId == null ||
        assignmentTitle.text.isEmpty ||
        assignmentDesc.text.isEmpty ||
        selectedDate == null) return;

    await FirebaseFirestore.instance
        .collection('courses')
        .doc(selectedCourseId)
        .collection('assignments')
        .add({
      'title': assignmentTitle.text.trim(),
      'description': assignmentDesc.text.trim(),
      'dueDate': selectedDate, // ✅ correct
    });

    assignmentTitle.clear();
    assignmentDesc.clear();
    selectedDate = null;

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Assignment Added")));
  }

  // CARD UI
  Widget sectionCard(String title, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: SafeArea(
        child: Column(
          children: [

            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.indigo],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Admin Dashboard",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Manage Courses, Videos & Assignments",
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [

                    // ADD COURSE
                    sectionCard(
                      "Add Course",
                      Column(
                        children: [
                          TextField(
                            controller: courseTitle,
                            decoration: inputStyle("Course Title"),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: courseDesc,
                            decoration: inputStyle("Description"),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: addCourse,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text("Add Course"),
                          ),
                        ],
                      ),
                    ),

                    // SELECT COURSE
                    sectionCard(
                      "Select Course",
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('courses')
                            .snapshots(),
                        builder: (context, snapshot) {

                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final courses = snapshot.data!.docs;

                          return DropdownButtonFormField(
                            value: selectedCourseId,
                            decoration: inputStyle("Choose Course"),
                            items: courses.map((doc) {
                              return DropdownMenuItem(
                                value: doc.id,
                                child: Text(doc['title']),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedCourseId = val as String;
                              });
                            },
                          );
                        },
                      ),
                    ),

                    // ADD VIDEO
                    sectionCard(
                      "Add Video",
                      Column(
                        children: [
                          TextField(
                            controller: videoTitle,
                            decoration: inputStyle("Video Title"),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: videoUrl,
                            decoration: inputStyle("YouTube URL"),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: addVideo,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text("Add Video"),
                          ),
                        ],
                      ),
                    ),

                    // ADD ASSIGNMENT
                    sectionCard(
                      "Add Assignment",
                      Column(
                        children: [

                          TextField(
                            controller: assignmentTitle,
                            decoration: inputStyle("Assignment Title"),
                          ),

                          const SizedBox(height: 10),

                          TextField(
                            controller: assignmentDesc,
                            decoration: inputStyle("Description"),
                          ),

                          const SizedBox(height: 10),

                          // DATE PICKER
                          ElevatedButton(
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              if (picked != null) {
                                setState(() {
                                  selectedDate = picked;
                                });
                              }
                            },
                            child: Text(
                              selectedDate == null
                                  ? "Select Due Date"
                                  : "Due: ${selectedDate!.toLocal()}".split(' ')[0],
                            ),
                          ),

                          const SizedBox(height: 10),

                          ElevatedButton(
                            onPressed: addAssignment,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text("Add Assignment"),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}