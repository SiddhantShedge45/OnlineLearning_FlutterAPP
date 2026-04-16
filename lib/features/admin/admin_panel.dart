import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Teacher Panel")),

      body: ListView(
        children: [

          ListTile(
            title: const Text("Add Course"),
            onTap: () {},
          ),

          ListTile(
            title: const Text("Upload Video"),
            onTap: () {},
          ),

          ListTile(
            title: const Text("Add Assignment"),
            onTap: () {},
          ),

        ],
      ),
    );
  }
}