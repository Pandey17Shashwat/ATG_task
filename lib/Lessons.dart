import 'package:flutter/material.dart';

class LessonsForYou extends StatelessWidget {
  final String name;
  final String category;
  final int duration;
  final bool lock;

  LessonsForYou(this.name, this.category, this.duration, this.lock);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      child: Column(children: [
        Image.asset('assets/photo2.png'),
        const SizedBox(height: 4),
        const Text('BABYCARE',
            style: TextStyle(
                color: Colors.blue,
                fontFamily: 'inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 12),
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
        const SizedBox(height: 4),
        Text(name,
            style: const TextStyle(
                fontFamily: 'inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 12),
                softWrap: true,
                overflow: TextOverflow.fade
            ),
        const SizedBox(
          height: 2,
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(category,
              style: const TextStyle(
                  fontFamily: 'inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Text(duration.toString(),
                  style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'inter',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 12)),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: const SizedBox(width: 25)),
            if(lock == true)Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: const Icon(Icons.lock))
          ],
        ),
      ]),
    );
  }
}
