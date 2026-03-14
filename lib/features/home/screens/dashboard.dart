import 'package:flutter/material.dart';
import '../../courses/screens/courses_screen.dart';
import '../../assignments/screens/assignment_screen.dart';
import '../../attendance/screens/attendance_screen.dart';
import '../../profile/profile_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Dashboard"),
      ),

      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,

        children: [

          DashboardCard(
            title: "Courses",
            icon: Icons.menu_book,
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
    );
  }
}

class DashboardCard extends StatelessWidget {

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: onTap,

      borderRadius: BorderRadius.circular(20),

      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
            )
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(icon, size: 40),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
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