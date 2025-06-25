import 'package:ecohub/models/advisory_model/advisory_model.dart';
import 'package:flutter/material.dart';

class AdvisoryScreen extends StatelessWidget {
  final List<Advisory> advisories = Advisory.getAdvisories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advisories',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: advisories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 7, right: 7, top: 2, bottom: 2),
            child: Card(
              color: Colors.grey.shade300,
              child: ExpansionTile(
                expansionAnimationStyle: AnimationStyle(
                  duration: Duration(seconds: 1),
                  curve: Curves.bounceOut,
                  reverseDuration: Duration(seconds: 1),
                  reverseCurve: Curves.decelerate,
                ),
                iconColor: Colors.blue,
                textColor: Colors.blue,
                collapsedIconColor: Colors.orange,
                title: Text(
                  advisories[index].headline,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(advisories[index].content),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
