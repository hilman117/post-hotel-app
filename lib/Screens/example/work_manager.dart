import 'package:flutter/material.dart';

class WorkManagerTes extends StatefulWidget {
  const WorkManagerTes({super.key});

  @override
  State<WorkManagerTes> createState() => _WorkManagerTesState();
}

class _WorkManagerTesState extends State<WorkManagerTes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              // Workmanager().registerOneOffTask("TaksOne", "BackUp",
              //     initialDelay: const Duration(seconds: 5));
            },
            child: const Text("Task")),
      ),
    );
  }
}
