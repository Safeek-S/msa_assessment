import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:msa_assessment/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:msa_assessment/presentation/stats_screen/stats_screen.dart';
import 'package:msa_assessment/presentation/widgets/bottom_navigation/bottom_navigation.dart';
import 'package:msa_assessment/presentation/widgets/bottom_navigation/bottom_navigation_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }

  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
      label: 'Stats',
    ),
  ];

  late List<Widget> screens = [
    const DashboardScreen(),
    const StatsScreen(),
  ];
  final BottomNavigationModel model = BottomNavigationModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => screens[model.selectedIndex],
      ),
      bottomNavigationBar:
          BottomNavBar(bottomNavigationModel: model, items: items),
    );
  }
}
