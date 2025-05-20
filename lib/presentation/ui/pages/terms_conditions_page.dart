import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms and Conditions')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            Text(
              'Agreement to Terms',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'By accessing or using the ShareMyStuff application ("the App"), you agree to be bound by these Terms and Conditions. If you disagree with any part of these terms, you may not access or use the App',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),

            Text(
              'Account Registration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'To use certain features of the App, you must register for an account. You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),

            Text(
              'User Conduct',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text('''
Users of ShareMyStuff agree to:
1. Not post false, misleading, or deceptive listings.
2. Not harass, abuse, or harm other users.
3. Not use the App for any illegal purposes.
4. Accurately represent the condition and description of items offered.
5. Meet safely and respectfully when exchanging items.
6. Honor commitments made to other users regarding item pickups or exchanges
''', style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text(
              'Item Listings and Exchanges',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'ShareMyStuff facilitates connections between users but is not a party to any transaction between users. We do not guarantee the quality, safety, or legality of items posted, nor the accuracy of listings. All exchanges are conducted at users own risk.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Intellectual Property',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'The App and its original content, features, and functionality are owned by ShareMyStuff and are protected by international copyright, trademark, patent, trade secret, and other intellectual property laws.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Limitation of Liability',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'ShareMyStuff shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your access to or use of, or inability to access or use, the App or any content provided through the App',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Termination',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'We may terminate or suspend your account immediately, without prior notice, for conduct that we believe violates these Terms and Conditions or is harmful to other users, the App, or third parties, or for any other reason at our sole discretion.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
