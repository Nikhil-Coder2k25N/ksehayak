import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ksehayak/Screens/control.dart';
import 'package:ksehayak/Screens/dashboard.dart';
import 'package:ksehayak/Screens/finance.dart';
import 'package:ksehayak/Screens/monitor.dart';
import 'package:ksehayak/Screens/store.dart';

class InternalPage extends StatefulWidget {
  final int initialIndex; //For Drawer List Click Functionality
  const InternalPage({super.key, this.initialIndex = 0});
  @override
  State<InternalPage> createState() => _InternalPageState();
}

class _InternalPageState extends State<InternalPage> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; //For Drawer List Click Functionality
  }

  final List <Widget> _pages=[
    DashboardPage(),
    ControlPage(),
    MonitorPage(),
    StorePage(),
    FinancePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        iconSize: 27,
        elevation: 1,
        //selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        //unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined),label: 'Dashboard',backgroundColor: Colors.purpleAccent,activeIcon: Icon(Icons.dashboard_outlined,size: 25,),),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Control',backgroundColor: Colors.purpleAccent,activeIcon: Icon(Icons.settings,size: 25)),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up_outlined),label: 'Monitor',backgroundColor: Colors.purpleAccent,activeIcon: Icon(Icons.trending_up_outlined,size: 25,)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart),label: 'Store',backgroundColor: Colors.purpleAccent,activeIcon: Icon(CupertinoIcons.shopping_cart,size: 25,)),
          BottomNavigationBarItem(icon: Icon(Icons.currency_rupee),label: 'Finance',backgroundColor: Colors.purpleAccent,activeIcon: Icon(Icons.currency_rupee,size: 25,)),
        ],
      ),
    );
  }
}
