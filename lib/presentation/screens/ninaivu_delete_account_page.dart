import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class NinaivuDeleteAccountPage extends StatelessWidget {
  const NinaivuDeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkCardBg : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account and Data Request for Ninaivu'),
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
                      'Delete Account and Data Request for Ninaivu',
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
                    const _DeleteAccountParagraph(
                      text:
                          'Ninaivu is an insurance renewal reminder app developed by Devendiran Thiyagarajan. This page explains how Ninaivu users can request deletion of their account and associated app data.',
                    ),
                    const SizedBox(height: 32),
                    const _DeleteAccountSection(
                      heading: 'How to Request Account Deletion',
                      paragraphs: [
                        'To request deletion of your Ninaivu account and associated data, please send an email to:',
                        'devendiran.apps@gmail.com',
                        'Use the email subject:',
                        'Ninaivu Account Deletion Request',
                        'In your email, please include:',
                      ],
                      bullets: [
                        'Your registered mobile number or email address used to sign in to Ninaivu',
                        'Your name, if available',
                        'A short message confirming that you want your Ninaivu account and associated data to be deleted',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Example email message',
                      callout:
                          'Hello,\n\nI would like to request deletion of my Ninaivu account and associated app data.\n\nRegistered mobile/email:\nName:\n\nThank you.',
                    ),
                    const _DeleteAccountSection(
                      heading: 'What Data Will Be Deleted',
                      paragraphs: [
                        'After verifying the request, the following data associated with your Ninaivu account may be deleted:',
                      ],
                      bullets: [
                        'User account information',
                        'Login-related account identifiers',
                        'Client records created by the user',
                        'Policy records created by the user',
                        'Renewal reminder records',
                        'Follow-up records',
                        'Notes and other app data linked to the user account',
                        'Cloud data stored in Firebase services, if applicable',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Local Device Data',
                      paragraphs: [
                        'Some data may be stored locally on the user\'s device. Users can remove local app data by deleting records inside the app where available, clearing app storage from device settings, or uninstalling the app.',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'What Data May Be Retained',
                      paragraphs: [
                        'Some limited data may be retained when necessary for legitimate reasons such as:',
                      ],
                      bullets: [
                        'Security',
                        'Fraud prevention',
                        'Legal or regulatory compliance',
                        'Debugging records that do not directly identify active app content',
                        'Backup or server logs for a limited period',
                      ],
                      closingParagraphs: [
                        'If any data must be retained, it will only be kept for as long as necessary for the above purposes.',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Processing Time',
                      paragraphs: [
                        'Account and associated data deletion requests will usually be processed within 7 to 30 days after receiving and verifying the request.',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Additional Information',
                      paragraphs: [
                        'Deleting your Ninaivu account may permanently remove your saved clients, policies, reminders, follow-ups, and related app data. This action may not be reversible after completion.',
                      ],
                    ),
                    const _DeleteAccountSection(
                      heading: 'Contact',
                      paragraphs: [
                        'For account deletion, data deletion, privacy questions, or support, contact:',
                        'Email: devendiran.apps@gmail.com',
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

class _DeleteAccountSection extends StatelessWidget {
  final String heading;
  final List<String> paragraphs;
  final List<String> bullets;
  final List<String> closingParagraphs;
  final String? callout;

  const _DeleteAccountSection({
    required this.heading,
    this.paragraphs = const [],
    this.bullets = const [],
    this.closingParagraphs = const [],
    this.callout,
  });

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
                        style: theme.textTheme.bodyLarge?.copyWith(height: 1.7),
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
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.7),
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
  final String text;

  const _DeleteAccountParagraph({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.75),
    );
  }
}
