import 'package:flutter/material.dart';

/// Settings Screen
/// Demonstrates a simple settings screen accessible via named route

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('🔧 SettingsScreen initialized');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'App Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account'),
            subtitle: const Text('Manage your account'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              debugPrint('📍 Account settings tapped');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account settings clicked')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Manage notifications'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              debugPrint('📍 Notifications settings tapped');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications settings clicked')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Theme'),
            subtitle: const Text('Choose app theme'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              debugPrint('📍 Theme settings tapped');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Theme settings clicked')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacy & Security'),
            subtitle: const Text('Manage permissions'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              debugPrint('📍 Privacy settings tapped');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy settings clicked')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About App'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {
              debugPrint('📍 About app tapped');
              showAboutDialog(
                context: context,
                applicationName: 'iCuisine',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024 iCuisine. All rights reserved.',
              );
            },
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                debugPrint('🔙 Back to previous screen');
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('← Back to Previous Screen'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
