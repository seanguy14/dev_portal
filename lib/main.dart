import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'privacy_policy_page.dart';
import 'support_page.dart';

void main() {
  usePathUrlStrategy();
  runApp(const DevPortalApp());
}

class DevPortalApp extends StatelessWidget {
  const DevPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZA Developer Portal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/privacy': (context) => const PrivacyPolicyPage(),
        '/support': (context) => const SupportPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // We use LayoutBuilder to check the screen width
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Dev Portfolio"),
            // Only show actions (links) on Desktop; Mobile uses the Drawer
            actions: isMobile ? null : [
              TextButton(onPressed: () => Navigator.pushNamed(context, '/privacy'), child: const Text("Privacy Policy")),
              TextButton(onPressed: () => Navigator.pushNamed(context, '/support'), child: const Text("Support")),
              const SizedBox(width: 16),
            ],
          ),
          // Drawer is only available on Mobile
          drawer: isMobile ? Drawer(
            child: ListView(
              children: [
                const DrawerHeader(child: Center(child: Text("Menu"))),
                ListTile(title: const Text("Privacy Policy"), onTap: () => Navigator.pushNamed(context, '/privacy')),
                ListTile(title: const Text("Support"), onTap: () => Navigator.pushNamed(context, '/support')),
              ],
            ),
          ) : null,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(isMobile),
                _buildAppSection("Expense App", "Track your Rands effortlessly."),
                _buildAppSection("Receipt Scanner", "OCR for South African receipts."),
                _buildFooter(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(40),
      width: double.infinity,
      color: Colors.blueGrey.shade50,
      child: Column(
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 20),
          Text(
            "Hi, I'm a Flutter Developer",
            style: TextStyle(fontSize: isMobile ? 24 : 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Text("Building modern solutions in South Africa"),
        ],
      ),
    );
  }

  Widget _buildAppSection(String title, String desc) {
    return ListTile(
      contentPadding: const EdgeInsets.all(20),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(desc),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.grey.shade100,
      child: const Center(
        child: Text("© 2024 ZA Developer. All rights reserved."),
      ),
    );
  }
}