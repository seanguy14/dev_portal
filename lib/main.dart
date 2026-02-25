import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

// Your page imports
import 'privacy_policy_page.dart';
import 'support_page.dart';
import 'terms_of_service_page.dart';

void main() {
  // Removes the '#' from the URL
  usePathUrlStrategy();
  runApp(const DevPortalApp());
}

// 1. Define the GoRouter configuration
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/privacy',
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: '/support',
      builder: (context, state) => const SupportPage(),
    ),
    GoRoute(
      path: '/terms',
      builder: (context, state) => const TermsOfServicePage(),
    ),
  ],
);

class DevPortalApp extends StatelessWidget {
  const DevPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Change MaterialApp to MaterialApp.router
    return MaterialApp.router(
      title: 'ZA Developer Portal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      routerConfig: _router, // 3. Attach the router
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      // You can replace this with a SnackBar if you prefer
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Dev Portfolio"),
            // Desktop Navbar
            actions: isMobile ? null : [
              TextButton(
                onPressed: () => context.go('/'), 
                child: const Text("Home")
              ),
              TextButton(
                onPressed: () => context.go('/support'), 
                child: const Text("Support")
              ),
              TextButton(
                onPressed: () => context.go('/terms'), 
                child: const Text("Terms")
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () => context.go('/privacy'), 
                  child: const Text("Privacy Policy")
                ),
              ),
            ],
          ),
          // Mobile Hamburger Menu
          drawer: isMobile ? Drawer(
            child: ListView(
              children: [
                const DrawerHeader(child: Center(child: Text("Menu"))),
                ListTile(
                  title: const Text("Home"), 
                  onTap: () {
                    Navigator.pop(context); // Close the drawer first
                    context.go('/');        // Then navigate
                  }
                ),
                ListTile(
                  title: const Text("Support"), 
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/support');
                  }
                ),
                ListTile(
                  title: const Text("Terms of Service"), 
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/terms');
                  }
                ),
                ListTile(
                  title: const Text("Privacy Policy"), 
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/privacy');
                  }
                ),
              ],
            ),
          ) : null,
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeroSection(isMobile),
                    // Showcasing your current projects
                    _buildAppSection("Expense", "Track your Rands effortlessly.", "https://play.google.com/store/apps/dev?id=YOUR_DEV_ID"),
                    _buildAppSection("Receipt Scanner", "OCR for South African receipts.", "https://play.google.com/store/apps/dev?id=YOUR_DEV_ID"),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      width: double.infinity,
      color: Colors.blueGrey.shade50,
      child: Column(
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 20),
          Text(
            "Hi, I'm Sean",
            style: TextStyle(fontSize: isMobile ? 24 : 40, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Text("Flutter Developer in South Africa"),
        ],
      ),
    );
  }

  Widget _buildAppSection(String title, String desc, String linkStr) {
    return ListTile(
      contentPadding: const EdgeInsets.all(20),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(desc),
      trailing: const Icon(Icons.open_in_new), // Better icon for external links
      onTap: () => _launchURL(linkStr),
    );
  }
}