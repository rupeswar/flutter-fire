import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/screens/settings.dart';
import 'package:flutter_fire/services/firestoreService.dart';
import 'package:flutter_fire/services/phone_auth.dart';
import 'package:flutter_fire/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = Provider.of<FirestoreService>(context);
    ConnectivityResult connectivityResult =
        Provider.of<ConnectivityResult>(context);

    return Consumer<ThemeNotifier>(
      builder: (context, themenotifier, child) {
        ThemeData theme = themenotifier.getTheme();

        return Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: appBar(context),
          body: Center(
            child: Column(
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(color: theme.accentColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Your registered number is: ${firestoreService.phoneNo}',
                  style: TextStyle(color: theme.accentColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Email Verified? : ${FirebaseAuth.instance.currentUser.emailVerified}',
                  style: TextStyle(color: theme.accentColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Display Name : ${FirebaseAuth.instance.currentUser.displayName}',
                  style: TextStyle(color: theme.accentColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: connectivityResult == ConnectivityResult.none
                      ? Colors.red
                      : Colors.green,
                  height: 20,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  child: Text(
                    'Sign Out',
                    style: TextStyle(color: theme.accentColor),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    PhoneAuth().signout();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Home Screen',
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (BuildContext context) => SettingsPage(),
                ),
              );
            }),
      ],
    );
  }
}
