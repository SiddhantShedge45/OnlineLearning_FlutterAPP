import 'package:flutter/material.dart';
import 'video_player_screen.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  final List<Map<String,String>> courses = const [

    {
      "title": "Flutter Basics",
      "video": "1ukSR1GRtMU"
    },

    {
      "title": "Machine Learning Intro",
      "video": "GwIo3gDZCVQ"
    },

    {
      "title": "Data Structures",
      "video": "RBSGKlAvoiM"
    }

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Courses")),

      body: ListView.builder(
        itemCount: courses.length,

        itemBuilder: (context,index){

          return Card(

            child: ListTile(

              title: Text(courses[index]["title"]!),

              trailing: const Icon(Icons.play_circle),

              onTap: (){

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) => VideoPlayerScreen(
                      videoId: courses[index]["video"]!,
                    ),
                  ),
                );

              },

            ),
          );
        },
      ),
    );
  }
}