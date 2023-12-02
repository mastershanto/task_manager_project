import 'package:flutter/material.dart';



class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,required this.count,required this.title
  });
  final  count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 32),
        child: Column(
          children: [
            Text(count.toString(),style:Theme.of(context).textTheme.titleLarge),
            Text(title),
          ],
        ),
      ),
    );
  }
}

