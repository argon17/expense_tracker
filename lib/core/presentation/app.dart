import 'package:expense_tracker/features/overview/presentation/overview.dart';
import 'package:expense_tracker/features/history/presentation/history.dart';
import 'package:expense_tracker/features/statistics/presentation/stats.dart';
import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final List<Widget> _widgetOptions = const [
    HistoryPage(),
    OverviewPage(),
    StatsPage(),
  ];
  int _selectedIndex = 1;

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.blueGrey,
        currentIndex: _selectedIndex,
        items: _bottomNavigationBarItems
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.label,
                  activeIcon: Icon(item.activeIcon),
                ))
            .toList(),
      ),
    );
  }
}

const _bottomNavigationBarItems = <_Item>[
  _Item(
    'History',
    icon: Icons.history,
    activeIcon: Icons.history,
  ),
  _Item(
    'Overview',
    icon: Icons.home,
    activeIcon: Icons.home,
  ),
  _Item(
    'Stats',
    icon: Icons.trending_up,
    activeIcon: Icons.trending_up,
  ),
];

class _Item {
  final String label;
  final IconData icon, activeIcon;
  const _Item(this.label, {required this.icon, required this.activeIcon});
}
