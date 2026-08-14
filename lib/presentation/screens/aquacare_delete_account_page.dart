import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AquacareDeleteAccountPage extends StatelessWidget {
  const AquacareDeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkCardBg : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delete Account and Data Request for AquaCare CRM',
        ),
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
                      'Delete Account and Data Request for AquaCare CRM',
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
                    const _DeleteAccountParagraph(
                      text:
                          'AquaCare CRM is a business customer management application developed by Devendiran Thiyagarajan. This page explains how AquaCare CRM users can request deletion of their account and associated personal account data.',
                    ),
                    const SizedBox(height: 32),
                    const _DeleteAccountSection(
                      heading: 'How to Request Account Deletion',
                      paragraphs: [
                        'To request deletion of your AquaCare CRM account and associated personal account information, please send an email to:',
                        'devendiran.apps@gmail.com',
                        'Use the email subject:',
                        'AquaCare CRM Account Deletion Request',
                        'Please include the following information in your request:',
                      ],
                      bullets: [
                        'The email address used to sign in to AquaCare CRM',
                        'Your name, if available',
                        'A short statement confirming that you want your AquaCare CRM account and associated personal account data deleted',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Example email message',
                      callout:
                          'Hello,\n\nI would like to request deletion of my AquaCare CRM account and associated personal account data.\n\nRegistered email:\nName:\n\nThank you.',
                    ),
                    const _DeleteAccountSection(
                      heading: 'What May Be Deleted',
                      paragraphs: [
                        'After verifying the request, account-related information associated with the user may be deleted, including:',
                      ],
                      bullets: [
                        'AquaCare user profile information',
                        'Firebase Authentication account',
                        'Login-related account identifiers',
                        'Account role and account status information',
                        'Other personal account information associated with the AquaCare account',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Business and Customer Data',
                      paragraphs: [
                        'AquaCare CRM is a business CRM. Customer records and other business information may be shared records belonging to the organization using AquaCare CRM rather than personal account information belonging to an individual employee or technician.',
                        'Deleting a user account does not necessarily mean that shared business or customer records will be deleted.',
                        'Business records may be retained where necessary for legitimate business, operational, security, legal, or regulatory purposes.',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Local Device Data',
                      paragraphs: [
                        'Information stored locally on the user\'s Android device may remain on the device until the user removes it.',
                        'Users may remove local app data through available application controls, Android device settings, or by uninstalling the application.',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Data That May Be Retained',
                      paragraphs: [
                        'In limited circumstances, some information may need to be retained for legitimate purposes such as:',
                      ],
                      bullets: [
                        'Security',
                        'Fraud prevention',
                        'Legal or regulatory compliance',
                        'Business record retention',
                        'Required audit or operational records',
                        'Limited technical or server records',
                      ],
                      closingParagraphs: [
                        'Where retention is required, information will be kept only for as long as reasonably necessary for the relevant purpose.',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Processing Time',
                      paragraphs: [
                        'Account deletion requests will be reviewed and processed after the request has been verified.',
                        'Requests will normally be processed within 7 to 30 days.',
                        'Additional time may be required when verification or legally required retention considerations apply.',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Important Information',
                      paragraphs: [
                        'Deleting your AquaCare CRM account may permanently remove your personal account information and access to the AquaCare account.',
                        'This action may not be reversible after completion.',
                        'Deletion of an individual account does not automatically delete shared business or customer records belonging to the organization.',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Contact',
                      paragraphs: [
                        'For account deletion, data deletion, privacy questions, or support:',
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

class _DeleteAccountSection extends StatelessWidget {
  const _DeleteAccountSection({
    required this.heading,
    this.paragraphs = const [],
    this.bullets = const [],
    this.closingParagraphs = const [],
    this.callout,
  });

  final String heading;
  final List<String> paragraphs;
  final List<String> bullets;
  final List<String> closingParagraphs;
  final String? callout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
            _DeleteAccountParagraph(text: paragraph),
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
          if (callout != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.03)
                    : Colors.black.withValues(alpha: 0.02),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              child: Text(
                callout!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.7,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          for (final paragraph in closingParagraphs) ...[
            _DeleteAccountParagraph(text: paragraph),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _DeleteAccountParagraph extends StatelessWidget {
  const _DeleteAccountParagraph({required this.text});

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
