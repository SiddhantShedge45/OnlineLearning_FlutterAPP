import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'video_player_screen.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Courses")),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('courses').snapshots(),
        builder: (context, snapshot) {

          // 🔄 Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ No data
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Courses Found"));
          }

          final courses = snapshot.data!.docs;

          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {

              final course =
              courses[index].data() as Map<String, dynamic>;

              // 🔍 DEBUG (check console)
              print(course);

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(course['title'] ?? 'No Title'),
                  subtitle: Text(course['description'] ?? 'No Description'),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CourseVideosScreen(
                          courseId: courses[index].id,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CourseVideosScreen extends StatelessWidget {
  final String courseId;

  const CourseVideosScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Videos")),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('courses')
            .doc(courseId)
            .collection('videos')
            .snapshots(),
        builder: (context, snapshot) {

          // 🔄 Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ No videos
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Videos Found"));
          }

          final videos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {

              final video =
              videos[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(video['title'] ?? 'No Title'),
                  subtitle: Text(video['youtubeUrl'] ?? ''),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoPlayerScreen(
                          title: video['title'] ?? 'No Title',
                          videoUrl: video['youtubeUrl'] ?? '',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}