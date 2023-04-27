import 'package:flutter/material.dart';

class NewFeedScreen extends StatefulWidget {
  const NewFeedScreen({super.key});
  static const String routeName = '/new_feed_screen';
  @override
  State<NewFeedScreen> createState() => _NewFeedScreenState();
}

class _NewFeedScreenState extends State<NewFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('New Feed Updates hello')),
      ),
    );
  }
}
