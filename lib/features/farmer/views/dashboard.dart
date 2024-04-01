import 'package:flutter/material.dart';
import 'package:harvestlink_app/engine/storage/local_storage.dart';
import 'package:harvestlink_app/features/auth/views/login.dart';
import 'package:harvestlink_app/features/farmer/widgets/app_bar.dart';
import 'package:harvestlink_app/templates/components/text_components.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final localStorage = LocalStorage();
  int navIndex = 0;

  Widget _getPage(int index, screenSize) {
    switch (index) {
      case 0:
        return const Center(child: Text("Farmer dashboard"),);
      case 1:
        return const Center(child: Text('Market Page'));
      case 2:
        return const Center(child: Text('Orders Page'));
      case 3:
        return Center(
          child: Column(
            children: [
              const Text('Profile Page'),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  localStorage.setIsLoggedIn(false);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder)=> const LoginScreen()));
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: FarmerAppBar(
        appBarHeight: screenSize.height * 0.08,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerTextBlack("HarvestLink"),
          ],
        ),
      ),
      body: _getPage(navIndex, screenSize),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.green.shade100,
        indicatorColor: Colors.green.shade500,
        selectedIndex: navIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.store),
            label: 'Market',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            navIndex = index;
          });
        },
      ),
    );
  }
}
