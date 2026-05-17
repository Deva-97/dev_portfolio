import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class NinaivuPrivacyPolicyPage extends StatelessWidget {
  const NinaivuPrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkCardBg : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy for Ninaivu'),
        centerTitle: false,
      ),
      body: SelectionArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy Policy for Ninaivu',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Effective Date: May 17, 2026',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _PolicyParagraph(
                      text:
                          'Ninaivu is an insurance renewal reminder app designed to help insurance agents manage clients, policies, renewal dates, follow-ups, and reminder notifications.',
                    ),
                    const SizedBox(height: 16),
                    const _PolicyParagraph(
                      text:
                          'This Privacy Policy explains what information Ninaivu collects, how it is used, how it is stored, and how users can contact us regarding their data.',
                    ),
                    const SizedBox(height: 32),
                    const _PolicySection(
                      heading: '1. Information We Collect',
                      paragraphs: [
                        'User Account Information',
                        'When users sign in using Google Sign-In or mobile number login, Ninaivu may collect basic account information such as name, mobile number, email address if available through Google Sign-In, and authentication identifiers provided by Firebase Authentication.',
                        'Client and Policy Information',
                        'Users may manually enter client and insurance policy details, including client names, mobile numbers, alternate contact numbers, address or area, insurance type, policy number, insurance provider or company, policy start and expiry dates, premium amount, payment frequency, vehicle details if applicable, follow-up notes, and reminder details.',
                        'This information is entered by the user for managing insurance renewals and follow-ups.',
                        'App Usage and Diagnostics',
                        'Ninaivu may use Firebase Crashlytics to collect crash reports and diagnostic information to improve app stability and performance. This may include device details, crash logs, app version, and technical error information.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '2. How We Use the Information',
                      paragraphs: [
                        'We use the collected or stored information to:',
                      ],
                      bullets: [
                        'Allow users to log in securely',
                        'Manage client and policy records',
                        'Show policy renewal reminders',
                        'Send local notification reminders',
                        'Help users track follow-ups',
                        'Sync data with Firebase services, if enabled',
                        'Improve app stability and fix crashes',
                        'Provide support and troubleshoot issues',
                      ],
                      closingParagraphs: [
                        'We do not sell user data.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '3. Data Storage',
                      paragraphs: [
                        'Ninaivu may store data locally on the user’s device using local database storage. Some data may also be synced or stored using Firebase services, depending on the app features enabled.',
                        'Local data remains on the user’s device unless sync or backup features are used.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '4. Notifications',
                      paragraphs: [
                        'Ninaivu uses notification permission to send reminders for policy renewals and follow-ups. These notifications are used only for app functionality and are based on the reminder information created by the user.',
                        'The app may also use boot-related permission to restore scheduled reminders after the device restarts.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '5. Third-Party Services',
                      paragraphs: [
                        'Ninaivu may use the following third-party services:',
                      ],
                      bullets: [
                        'Firebase Authentication',
                        'Google Sign-In',
                        'Firebase Firestore',
                        'Firebase Crashlytics',
                      ],
                      closingParagraphs: [
                        'These services may collect and process data according to their own privacy policies and security practices.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '6. Data Sharing',
                      paragraphs: [
                        'Ninaivu does not sell personal data.',
                        'User data may be processed by third-party service providers such as Firebase only for app functionality, authentication, cloud sync, crash reporting, and app improvement.',
                        'We may disclose information if required by law or to comply with legal obligations.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '7. Data Security',
                      paragraphs: [
                        'We take reasonable steps to protect user data. Data transmitted to Firebase services is handled through secure communication methods. However, no method of electronic storage or transmission is 100% secure, so we cannot guarantee absolute security.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '8. User Control and Data Deletion',
                      paragraphs: [
                        'Users can manage or delete client, policy, reminder, and follow-up information within the app where deletion options are available.',
                        'For account-related data deletion or support requests, users can contact us using the email address below.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '9. Children’s Privacy',
                      paragraphs: [
                        'Ninaivu is not intended for children. The app is designed for insurance agents and professional users. We do not knowingly collect personal information from children.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '10. Changes to This Privacy Policy',
                      paragraphs: [
                        'We may update this Privacy Policy from time to time. Any changes will be posted on this page with an updated effective date.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '11. Contact Us',
                      paragraphs: [
                        'For privacy-related questions, support, or data deletion requests, contact:',
                        'Email: devendiran03@gmail.com',
                      ],
                    ),
                    const SizedBox(height: 24),
                    Divider(color: borderColor),
                    const SizedBox(height: 16),
                    Text(
                      '© 2026 Ninaivu. All rights reserved.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String heading;
  final List<String> paragraphs;
  final List<String> bullets;
  final List<String> closingParagraphs;

  const _PolicySection({
    required this.heading,
    required this.paragraphs,
    this.bullets = const [],
    this.closingParagraphs = const [],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          for (final paragraph in paragraphs) ...[
            _PolicyParagraph(text: paragraph),
            const SizedBox(height: 12),
          ],
          if (bullets.isNotEmpty) ...[
            for (final bullet in bullets)
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '•',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        bullet,
                        style: theme.textTheme.bodyLarge?.copyWith(height: 1.7),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 2),
          ],
          for (final paragraph in closingParagraphs) ...[
            _PolicyParagraph(text: paragraph),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _PolicyParagraph extends StatelessWidget {
  final String text;

  const _PolicyParagraph({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.75),
    );
  }
}
