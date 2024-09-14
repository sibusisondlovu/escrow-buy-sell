
import 'package:flutter/material.dart';
import 'package:mobile_app/ui/screens/main_layout_screen.dart';
import 'package:mobile_app/ui/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/theme.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});
  static const String id = 'wrapper';

  @override
  State<Wrapper> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkFirstTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator(color: AppTheme.mainColor, strokeWidth: 2,)));
        } else if (snapshot.hasError) {
          // Handle any errors
          return Scaffold(body: Center(child: Text('Error: ${snapshot.error}')));
        } else {
          return const MainLayout();
        }
      },
    );
  }

  Future<bool> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_time') ?? true;
  }
}