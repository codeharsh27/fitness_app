import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Terms & Conditions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.description, color: Colors.red, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Last updated: December 10, 2024',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Terms Sections
            _buildTermsSection(
              title: 'Acceptance of Terms',
              content: 'By accessing and using Fitness App SaaS, you accept and agree to be bound by the terms and provision of this agreement. Please read these terms carefully before using our services.',
            ),

            _buildTermsSection(
              title: 'Use License',
              content: 'Permission is granted to temporarily download one copy of the app for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not modify or copy the materials.',
            ),

            _buildTermsSection(
              title: 'User Accounts',
              content: 'When you create an account with us, you must provide information that is accurate, complete, and current at all times. You are responsible for safeguarding the password and for all activities that occur under your account.',
            ),

            _buildTermsSection(
              title: 'Subscription and Payment',
              content: 'Subscription fees are billed in advance on a monthly or yearly basis. You can cancel your subscription at any time, but refunds are provided according to our refund policy. All fees are non-refundable unless otherwise stated.',
            ),

            _buildTermsSection(
              title: 'Content and Conduct',
              content: 'You are solely responsible for the content you post or share through our services. You agree not to use the service for any unlawful purposes or to conduct any unlawful activity, including but not limited to fraud, embezzlement, or money laundering.',
            ),

            _buildTermsSection(
              title: 'Intellectual Property',
              content: 'The service and its original content, features, and functionality are and will remain the exclusive property of Fitness App SaaS and its licensors. The service is protected by copyright, trademark, and other laws.',
            ),

            _buildTermsSection(
              title: 'Privacy Policy',
              content: 'Your privacy is important to us. Please review our Privacy Policy, which also governs your use of the service, to understand our practices regarding the collection and use of your information.',
            ),

            _buildTermsSection(
              title: 'Termination',
              content: 'We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the terms. Upon termination, your right to use the service will cease immediately.',
            ),

            _buildTermsSection(
              title: 'Limitation of Liability',
              content: 'In no event shall Fitness App SaaS, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential, or punitive damages arising from your use of the service.',
            ),

            _buildTermsSection(
              title: 'Governing Law',
              content: 'These terms shall be interpreted and governed by the laws of the jurisdiction in which our company is incorporated, without regard to its conflict of law provisions. Our failure to enforce any right or provision of these terms will not be considered a waiver of those rights.',
            ),

            _buildTermsSection(
              title: 'Changes to Terms',
              content: 'We reserve the right, at our sole discretion, to modify or replace these terms at any time. If a revision is material, we will try to provide at least 30 days notice prior to any new terms taking effect.',
            ),

            _buildTermsSection(
              title: 'Contact Information',
              content: 'If you have any questions about these Terms and Conditions, please contact us at legal@fitnessapp.com or through our support channels.',
            ),

            const SizedBox(height: 32),

            // Agreement Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.verified, color: Colors.red, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Agreement to Terms',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'By using our services, you acknowledge that you have read and understood these terms',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red, width: 1),
                    ),
                    child: Text(
                      'These terms constitute the entire agreement between you and Fitness App SaaS regarding our service and supersede all prior agreements.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red.shade200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsSection({
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade300,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
