import 'package:flutter/material.dart';
import 'package:winetopia_app/screens/home/event_info.dart';
import 'package:winetopia_app/screens/home/home_content.dart';
import 'package:winetopia_app/screens/home/profile.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;

  final List<Widget> _screens = [HomeContent(), Profile(), const EventInfo()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Winetopia 2025")),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: Colors.purpleAccent,
        selectedIndex: _currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          NavigationDestination(icon: Icon(Icons.info), label: "Info"),
        ],
      ),
    );
  }
}
