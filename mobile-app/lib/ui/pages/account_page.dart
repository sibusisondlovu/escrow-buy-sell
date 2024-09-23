import 'package:flutter/material.dart';

import '../../config/theme.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          Container(
            height:
            MediaQuery.of(context).size.height * 0.4, // 40% of screen height
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.mainColor,
                  AppTheme.ascentColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            // Add any child widgets you want inside the container
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListView(
              children: [
                Image.asset(
                  'assets/images/default-avatar.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'Sibusiso',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                Card(
                  child: ListTile(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, 'editProfileScreen');
                    },
                    leading: const Icon(Icons.person),
                    title: const Text('Personal Details', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),),
                    subtitle: const Text('Update your personal profile', style: TextStyle(
                        fontSize: 12
                    ),),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, 'purchaseHistory');
                    },
                    leading: const Icon(Icons.credit_card),
                    title: const Text('Purchase History', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),),
                    subtitle: const Text('View your purchase history', style: TextStyle(
                        fontSize: 12
                    ),),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.shopping_basket),
                    title: Text('Seller Profile', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),),
                    subtitle: Text('Manage Seller Profile', style: TextStyle(
                        fontSize: 12
                    ),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                )
              ],
            ),
          ),

        ]));
  }
}
