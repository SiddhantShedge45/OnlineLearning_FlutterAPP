import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: const [

            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person,size:40),
            ),

            SizedBox(height:20),

            Text(
              "Student Name",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
              ),
            ),

            Text("student@email.com")

          ],
        ),
      ),
    );
  }
}