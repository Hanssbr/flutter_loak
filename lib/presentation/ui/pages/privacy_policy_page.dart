import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            Text(
              'introduction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to GiveBox, the community platform where users can share and acquire unused items. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our application we are committed to protecting your personal information and your right to privacy.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),

            Text(
              'Information We Collect',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'We collect information that you provide directly to us when creating an account, listing items, communicating with other users, or contacting our support team. This may include your name, email address, phone number, profile picture, location data, and information about the items you wish to share or acquire',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),

            Text(
              'How We Use Your Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'Your information helps us personalize your experience, improve our platform, facilitate transactions between users, send you notifications about items that match your ineterest, and maintain the security of our services. We may also use your data to analyze usage patterns and optimize our application features.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Sharing Your Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'We may share your information with other users as necessary to facilitate item exchanges. For example, when you list an item, your general location and contact method will be visible to interested parties. We may also share data with service providers who assist us in operating our platform',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Security Measures',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'We implement appropriate technical and organizational measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of electronic transmission or storage is 100% secure, and we cannot guarantee absolute security.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Your Choices',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'You can update, correct, or delete certain information from your profile at any time. You may also adjust your notification preferences or opt out of certain communications. If you wish to delete your account entirely, please contact us through the support section of the app.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              'We may update this Privacy Policy periodically to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify you of any material changes through the application or via the contact information you have provided.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
