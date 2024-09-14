import 'package:flutter/material.dart';
import 'package:mobile_app/ui/pages/account_page.dart';
import 'package:mobile_app/ui/pages/home_page.dart';
import 'package:mobile_app/ui/pages/post_listing_page.dart';
import 'package:provider/provider.dart';

import '../../config/theme.dart';
import '../../controllers/main_layout_notifier.dart';

class MainLayout extends StatefulWidget {
  static const String id = 'mainLayout';
  const MainLayout({
    super.key,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const PostListingPage(),
    const AccountPage()
  ];
  String _selectedLocation = 'New York'; // Default location
  String _searchQuery = '';

  // Sample locations
  List<String> _locations = ['New York', 'San Francisco', 'Los Angeles', 'Chicago'];

  void _onLocationChanged(String? newValue) {
    setState(() {
      _selectedLocation = newValue!;
      // TODO: Update product list based on selected location.
    });
  }
  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    // TODO: Implement search filtering logic based on _searchQuery.
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainLayoutNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: DropdownButton<String>(
              value: _selectedLocation,
              onChanged: _onLocationChanged,
              items: _locations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              underline: Container(),
              dropdownColor: Colors.white,
              icon: const Icon(Icons.location_on, color: Colors.white),
            ),
            backgroundColor: Colors.blue,
          ),
          body: IndexedStack(
            index: mainScreenNotifier.pageIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: 'Listing',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),

            ],
            currentIndex: mainScreenNotifier.pageIndex,
            selectedItemColor: AppTheme.mainColor,
            unselectedItemColor: Colors.grey,
            onTap: (value){
              mainScreenNotifier.pageIndex = value;
            },
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}