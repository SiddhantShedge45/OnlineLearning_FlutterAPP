import 'package:flutter/material.dart';

class AssignmentScreen extends StatelessWidget {

  const AssignmentScreen({super.key});

  final List assignments = const [

    "Build Flutter Login UI",
    "Implement Stack Data Structure",
    "Create AI Chatbot using Python",
    "Build REST API using Node.js"

  ];

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(title: const Text("Assignments")),

      body: ListView.builder(

        itemCount: assignments.length,

        itemBuilder: (context,index){

          return Card(

            child: ListTile(

              title: Text(assignments[index]),

              trailing: ElevatedButton(
                onPressed: (){},
                child: const Text("Submit"),
              ),

            ),

          );
        },
      ),
    );
  }
}