import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  int presentDays = 0;
  int totalDays = 0;

  void markAttendance(){

    setState(() {
      totalDays++;
      presentDays++;
    });

  }

  double getPercentage(){

    if(totalDays == 0) return 0;

    return (presentDays / totalDays) * 100;
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(title: const Text("Attendance")),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text(
              "Present: $presentDays / $totalDays",
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height:20),

            Text(
              "Attendance: ${getPercentage().toStringAsFixed(2)} %",
              style: const TextStyle(fontSize:20),
            ),

            const SizedBox(height:30),

            ElevatedButton(
              onPressed: markAttendance,
              child: const Text("Mark Present"),
            )

          ],
        ),
      ),
    );
  }
}