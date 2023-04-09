import 'package:flutter/material.dart';

class Programs extends StatelessWidget {
  final String name;
  final String category;
  final int lesson;
  Programs(this.name, this.category, this.lesson);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(children: [
          Image.asset('assets/photo1.png'),
          const SizedBox(height: 4),
          Text(
            category,
            style: const TextStyle(
                color: Colors.blue,
                fontFamily: 'inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700,
                fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(
              fontFamily: 'inter',
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
            ),
          ),
          // const SizedBox(
          //   height: 2,
          // ),
          // const Text(
          //   'new born baby',
          //   style: TextStyle(
          //     fontFamily: 'inter',
          //     fontSize: 16,
          //     fontStyle: FontStyle.normal,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),
          const SizedBox(height: 4),
          Text(
            lesson.toString(),
            style: const TextStyle(
              fontFamily: 'inter',
              fontSize: 12,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]),
      ),
    );
  }
}


