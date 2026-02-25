import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  // This function handles opening the default mail app
  Future<void> _launchEmail() async {
    // The 'mailto' scheme is what tells the OS to open an email client
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@yourdomain.co.za', // Replace with your actual email
      queryParameters: {
        'subject': 'Support Request - Expense App' // Pre-fills the subject line
      },
    );

    if (!await launchUrl(emailLaunchUri)) {
      debugPrint('Could not launch email client.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.support_agent, size: 80, color: Colors.blueGrey),
              const SizedBox(height: 20),
              const Text(
                "App Support",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                "Need help with Expense or have a general inquiry?\nClick the button below to send us a message.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              // The clickable email button
              ElevatedButton.icon(
                onPressed: _launchEmail,
                icon: const Icon(Icons.email),
                label: const Text("Email Support"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}