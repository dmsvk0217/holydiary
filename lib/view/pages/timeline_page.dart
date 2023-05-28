import 'package:flutter/material.dart';
import 'package:holydiary/view/components/writedfield.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: const [
        Writedfield(),
        SizedBox(height: 20),
        Writedfield(),
        SizedBox(height: 20),
        Writedfield(),
        SizedBox(height: 20),
        Writedfield(),
        SizedBox(height: 20),
        // Writingfield(),
        // SizedBox(height: 12),
        // Writingfield(),
        // SizedBox(height: 12),
      ]),
    );
  }
}
