import 'package:flutter/material.dart';

import '../../app_routes.dart';
import '../../core/theme/app_colors.dart';

class AquacarePrivacyPolicyPage extends StatelessWidget {
  const AquacarePrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkCardBg : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy for AquaCare CRM'),
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
                      'Privacy Policy for AquaCare CRM',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Effective Date: August 14, 2026',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _PolicyParagraph(
                      text:
                          'AquaCare CRM is a business customer management application designed to help authorized business users manage customer records, customer contact information, cities, user roles, and customer contact export.',
                    ),
                    const SizedBox(height: 16),
                    const _PolicyParagraph(
                      text:
                          'This Privacy Policy explains what information AquaCare CRM collects, how it is used, how it is stored, how it may be processed by third-party service providers, and how users can request account and data deletion.',
                    ),
                    const SizedBox(height: 32),
                    const _PolicySection(
                      heading: '1. Information We Collect',
                      paragraphs: [
                        'User Account Information',
                        'AquaCare CRM uses Google Sign-In for authentication. When a user signs in, AquaCare CRM may receive and store account information provided through Google Sign-In and Firebase Authentication, such as the user name, email address, Firebase authentication identifier (UID), and other authentication-related information required to maintain the AquaCare account.',
                        'AquaCare CRM may also store account access information such as the user role, account status, account creation and update timestamps, and information about which authorized user approved an account.',
                        'Customer and Business Information',
                        'Authorized AquaCare users may create and manage customer information in the CRM, including customer name, mobile number, address, city, pincode, customer creation and update information, information identifying the authorized user who created or updated a customer record, and customer record status where applicable.',
                        'This information is entered and managed by authorized users for business customer-management purposes.',
                        'Device Contacts',
                        'AquaCare CRM provides a user-initiated feature to export customer information to the Android device contacts. When the user chooses to use this feature, AquaCare CRM may request permission to access contacts on the device and may create or update device contact records using customer information such as name and mobile number.',
                        'The contact-export feature is initiated by the user and is provided for app functionality. Contact information accessed for this feature is not intended to be used for advertising.',
                        'Local Application Data',
                        'AquaCare CRM may store certain application state and operational information locally on the user device, including information required to manage contact-export status and application functionality.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '2. How We Use the Information',
                      paragraphs: [
                        'We use collected or stored information to:',
                      ],
                      bullets: [
                        'Authenticate users securely through Google Sign-In and Firebase Authentication',
                        'Maintain AquaCare user accounts and access permissions',
                        'Manage customer and business records',
                        'Provide customer search, sorting, and pagination',
                        'Manage user approval and role-based access',
                        'Export customer information to device contacts when requested by the user',
                        'Maintain application state required for app functionality',
                        'Protect Firebase resources and application services',
                        'Detect and prevent unauthorized application access',
                        'Support application updates and minimum-version enforcement',
                        'Provide support and troubleshoot application-related issues',
                      ],
                      closingParagraphs: [
                        'We do not sell personal information.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '3. Data Storage',
                      paragraphs: [
                        'AquaCare CRM may store application data using Firebase services, including Firebase Authentication and Cloud Firestore.',
                        'Some application-specific information may also be stored locally on the user\'s Android device.',
                        'Data transmitted to Firebase services is handled using secure communication methods provided by the platform and Firebase.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '4. Firebase and Google Services',
                      paragraphs: [
                        'AquaCare CRM uses third-party services provided by Google and Firebase for application functionality.',
                        'These services may include:',
                      ],
                      bullets: [
                        'Firebase Authentication',
                        'Google Sign-In',
                        'Cloud Firestore',
                        'Firebase App Check / Play Integrity',
                        'Firebase Remote Config',
                      ],
                      closingParagraphs: [
                        'These services may process information as necessary to provide authentication, database services, application security, application configuration, and related functionality. Their handling of information is also subject to their own privacy policies and terms.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '5. Data Sharing',
                      paragraphs: [
                        'AquaCare CRM does not sell personal information.',
                        'Information may be processed by service providers such as Google and Firebase where necessary to provide authentication, cloud database functionality, application security, remote application configuration, and other services required for AquaCare CRM to operate.',
                        'Information may also be disclosed when required by law, legal process, or a valid governmental request.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '6. Contact Export and User Control',
                      paragraphs: [
                        'The customer-contact export feature is optional and is initiated by the user.',
                        'When the user chooses to export customers to device contacts, AquaCare CRM may write customer information to the device\'s contact database.',
                        'Users control whether to grant Android contact permissions and may revoke those permissions through Android device settings.',
                        'The application does not require contact access simply to sign in or use normal CRM functionality.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '7. Data Security',
                      paragraphs: [
                        'We take reasonable technical and organizational measures to protect information handled by AquaCare CRM.',
                        'Firebase Authentication, Firestore security rules, Firebase App Check, and Google Play Integrity may be used to help protect application and backend resources.',
                        'However, no method of electronic storage or transmission can be guaranteed to be completely secure.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '8. Account Deletion and Data Deletion',
                      paragraphs: [
                        'AquaCare CRM allows users to request deletion of their account and associated personal account information.',
                        'Users can request account deletion from the AquaCare CRM application through the account-deletion option or through the external account-deletion web page below.',
                      ],
                    ),
                    _PolicyLinkSection(borderColor: borderColor),
                    const _PolicySection(
                      heading: '9. Business and Customer Data',
                      paragraphs: [
                        'AquaCare CRM is a business CRM. Customer records and other business information may be shared records belonging to the organization using AquaCare CRM rather than personal account information belonging to an individual employee or technician.',
                        'Deleting an individual user account does not necessarily mean that shared business or customer records will be deleted.',
                        'Such business records may be retained where necessary for legitimate business, operational, security, legal, or regulatory purposes. Any information that must be retained for a legitimate reason will be retained only for as long as reasonably necessary for that purpose.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '10. Children\'s Privacy',
                      paragraphs: [
                        'AquaCare CRM is intended for business and professional users.',
                        'The application is not directed toward children, and we do not knowingly collect personal information from children.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '11. Changes to This Privacy Policy',
                      paragraphs: [
                        'We may update this Privacy Policy from time to time.',
                        'When changes are made, the updated version will be published on this page together with a revised effective date.',
                      ],
                    ),
                    const _PolicySection(
                      heading: '12. Contact Us',
                      paragraphs: [
                        'For privacy questions, account deletion requests, data deletion requests, or support:',
                        'Developer: Devendiran Thiyagarajan',
                        'Email: devendiran.apps@gmail.com',
                        'App: AquaCare CRM',
                      ],
                    ),
                    const SizedBox(height: 24),
                    Divider(color: borderColor),
                    const SizedBox(height: 16),
                    Text(
                      '© 2026 Devendiran Thiyagarajan. All rights reserved.',
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
  const _PolicySection({
    required this.heading,
    required this.paragraphs,
    this.bullets = const [],
    this.closingParagraphs = const [],
  });

  final String heading;
  final List<String> paragraphs;
  final List<String> bullets;
  final List<String> closingParagraphs;

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
                      '-',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        bullet,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          height: 1.7,
                        ),
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
  const _PolicyParagraph({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.75,
          ),
    );
  }
}

class _PolicyLinkSection extends StatelessWidget {
  const _PolicyLinkSection({required this.borderColor});

  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.03)
              : Colors.black.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account and Data Deletion',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'To request account and associated data deletion, visit:',
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.7),
            ),
            const SizedBox(height: 6),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.aquacareDeleteAccount,
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft,
              ),
              child: const Text('/aquacare/delete-account'),
            ),
          ],
        ),
      ),
    );
  }
}
