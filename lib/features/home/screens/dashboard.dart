import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../courses/screens/courses_screen.dart';
import '../../assignments/screens/assignment_screen.dart';
import '../../attendance/screens/attendance_screen.dart';
import '../../profile/profile_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    super.initState();
    testFirebase();
  }

  void testFirebase() async {
    try {
      await FirebaseFirestore.instance.collection('test').add({
        'message': 'Firebase Connected',
        'time': DateTime.now(),
      });

      print("✅ Firebase Working");
    } catch (e) {
      print("❌ Firebase Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF5F7FB), // 🔥 light background

      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,

          children: [

            DashboardCard(
              title: "Courses",
              icon: Icons.menu_book,
              color: Colors.blue,
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CoursesScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              title: "Assignments",
              icon: Icons.assignment,
              color: Colors.orange,
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AssignmentScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              title: "Attendance",
              icon: Icons.check_circle,
              color: Colors.green,
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AttendanceScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              title: "Profile",
              icon: Icons.person,
              color: Colors.purple,
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),

      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient( // 🔥 gradient added
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(icon, size: 50, color: Colors.white),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

          ],
        ),
      ),
    );
  }
}