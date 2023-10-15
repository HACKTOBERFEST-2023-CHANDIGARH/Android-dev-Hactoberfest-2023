import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  final IconData icon;
  final String time;
  final String temp;
  const ForecastWidget(
      {super.key, required this.time, required this.temp, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Card(
        color: Colors.blueGrey[900],
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              time,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Icon(
              icon,
              size: 45,
            ),
            const SizedBox(height: 10),
            Text(
              temp,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
