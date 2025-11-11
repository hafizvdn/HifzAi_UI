import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// This is your import, make sure it's correct
import 'package:learningflutter/screens/AuthenticationPage/auth_choice_page.dart';

// --- File: lib/screens/ProfilePage/setting_page.dart ---
// This is the main page for your settings screen.

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // 🔹 Show sign-out confirmation dialog
  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Sign Out',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey[600]),
            ),
          ),
          TextButton(
            onPressed: () {
              // 🔸 Close dialog first
              Navigator.pop(context);

              // 🔸 TODO: Add your Firebase sign out logic here
              // Example: await FirebaseAuth.instance.signOut();

              // 🔸 Navigate to Authentication page and remove all previous routes
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Authentication(),
                ),
                (route) => false,
              );
            },
            child: Text(
              'Sign Out',
              style: GoogleFonts.poppins(
                color: Colors.red[700], // Changed to red for warning
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Show delete account confirmation dialog
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Account',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to permanently delete your account? This action cannot be undone.',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey[600]),
            ),
          ),
          TextButton(
            onPressed: () {
              // 🔸 Close dialog first
              Navigator.pop(context);

              // 🔸 TODO: Add your Firebase account deletion logic here
              // This is a complex operation, be sure to handle re-authentication

              // 🔸 Navigate to Authentication page and remove all previous routes
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Authentication(),
                ),
                (route) => false,
              );
            },
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(
                color: Colors.red[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Reusable Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // 🔹 Unified Setting List Item (with icons)
  Widget _buildSettingItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color? color, // Optional color for text
    bool showDivider = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: color ?? Colors.black87,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: color ?? Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: color ?? Colors.black87,
                ),
              ],
            ),
          ),
          if (showDivider)
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 20), // Indent divider
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey[200],
              ),
            ),
        ],
      ),
    );
  }

  // 🔹 Main UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF196580),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // --- ACCOUNT SECTION ---
                  _buildSectionTitle('Account'),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        _buildSettingItem(
                          title: 'Profile',
                          icon: Icons.person_outline,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileSettingsPage()));
                          },
                        ),
                        _buildSettingItem(
                          title: 'Change Password',
                          icon: Icons.lock_outline,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePasswordPage()));
                          },
                        ),
                        _buildSettingItem(
                          title: 'Delete Account',
                          icon: Icons.delete_outline,
                          onTap:
                              _showDeleteAccountDialog, // Shows a dialog
                          color: Colors.red[700], // Warning color
                          showDivider: false, // Last item in section
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- APP & GAME SECTION ---
                  _buildSectionTitle('App & Game'),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        _buildSettingItem(
                          title: 'Notifications',
                          icon: Icons.notifications_none,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationsSettingsPage()));
                          },
                        ),
                        _buildSettingItem(
                          title: 'Recitation',
                          icon: Icons.volume_up_outlined,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RecitationSettingsPage()));
                          },
                        ),
                        _buildSettingItem(
                          title: 'Game',
                          icon: Icons.gamepad_outlined,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GameSettingsPage()));
                          },
                          showDivider: false, // Last item in section
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- SUPPORT SECTION ---
                  _buildSectionTitle('Support'),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        _buildSettingItem(
                          title: 'Help & Support',
                          icon: Icons.help_outline,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const HelpSupportPage()));
                          },
                        ),
                        _buildSettingItem(
                          title: 'Rate HifzAi',
                          icon: Icons.star_outline,
                          onTap: () {
                            // TODO: Add logic to open App Store / Play Store
                            // e.g., using the `in_app_review` package
                            print('Open App Store');
                          },
                        ),
                        _buildSettingItem(
                          title: 'About',
                          icon: Icons.info_outline,
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const AboutPage()));
                          },
                          showDivider: false, // Last item in section
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // 🔹 Sign Out Button (Bottom)
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showSignOutDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[50], // Light red background
                  foregroundColor: Colors.red[700], // Dark red text
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0, // Flatter look
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.red[100]!), // Subtle border
                  ),
                ),
                child: Text(
                  'SIGN OUT',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// ===================================================================
// ==
// ==         PLACEHOLDER PAGES - Move each class to its own file
// ==
// ===================================================================
// ===================================================================

// --- File: lib/screens/settings/profile_settings_page.dart ---
// You can move this class to its own file at the path above.
// Remember to add: import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF196580),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Profile Settings Page',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}

// --- File: lib/screens/settings/change_password_page.dart ---
// You can move this class to its own file at the path above.
// Remember to add: import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF196580),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Change Password Page',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}

// --- File: lib/screens/settings/notifications_settings_page.dart ---
// You can move this class to its own file at the path above.
// Remember to add: import 'package:flutter/material.dart';

class NotificationsSettingsPage extends StatelessWidget {
  const NotificationsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF196580),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Notifications Settings Page',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}

// --- File: lib/screens/settings/recitation_settings_page.dart ---
// You can move this class to its own file at the path above.
// Remember to add: import 'package:flutter/material.dart';

class RecitationSettingsPage extends StatelessWidget {
  const RecitationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recitation Settings', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF196580),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Recitation Settings Page (e.g., Pick Qari)',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}

// --- File: lib/screens/settings/game_settings_page.dart ---
// You can move this class to its own file at the path above.
// Remember to add: import 'package/flutter/material.dart';

class GameSettingsPage extends StatelessWidget {
  const GameSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Settings', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF196580),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Game Settings Page (e.g., Sound Effects)',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}

// --- File: lib/screens/settings/help_support_page.dart ---
// You can move this class to its own file at the path above.
// Remember to add: import 'package/flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF196580),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Help & Support Page (e.g., FAQ)',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}

// --- File: lib/screens/settings/about_page.dart ---
// You can move this class to its own file at the path above.
// Remember to add: import 'package/flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About HifzAi', style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF196580),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'App Version 1.0.0',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}
