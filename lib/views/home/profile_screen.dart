// import 'package:farmhouse_app/views/profile/edit_profile.dart';
// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     // TextButton(
//                     //   onPressed: () => Navigator.pop(context),
//                     //   child: const Text(
//                     //     'Close',
//                     //     style: TextStyle(
//                     //       fontSize: 16,
//                     //       color: Colors.black,
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),

//               // Profile Picture
//               Container(
//                 width: 120,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.grey.shade300, width: 3),
//                   image: const DecorationImage(
//                     image: NetworkImage('https://upload.wikimedia.org/wikipedia/en/thumb/d/d6/Superman_Man_of_Steel.jpg/250px-Superman_Man_of_Steel.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Name
//               const Text(
//                 'Melvin',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 24),

//               // PERSONALIZE Section
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'PERSONALIZE',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey.shade600,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 8),

//               // Options
//               _buildMenuItem(
//                 icon: Icons.person_outline,
//                 title: 'Personal Details',
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
//                 },
//               ),
//               _buildMenuItem(
//                 icon: Icons.book_online,
//                 title: 'Past Bookings',
//                 onTap: () {},
//               ),
//               _buildMenuItem(
//                 icon: Icons.settings_outlined,
//                 title: 'Settings',
//                 onTap: () {},
//               ),

//               const SizedBox(height: 24),

//               // NEED HELP Section
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'NEED HELP?',
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey.shade600,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 8),

//               _buildMenuItem(
//                 icon: Icons.lightbulb_outline,
//                 title: 'Tips and Tricks',
//                 onTap: () {},
//               ),
//               _buildMenuItem(
//                 icon: Icons.help_outline,
//                 title: 'Frequently Asked Questions',
//                 onTap: () {},
//               ),
//               _buildMenuItem(
//                 icon: Icons.email_outlined,
//                 title: 'Contact Us',
//                 onTap: () {},
//               ),

//               const SizedBox(height: 24),

//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       child: Material(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(12),
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(12),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: Row(
//               children: [
//                 Icon(icon, size: 20, color: Colors.black),
//                 const SizedBox(width: 12),
//                 Text(
//                   title,
//                   style: const TextStyle(fontSize: 16),
//                 ),
//                 const Spacer(),
//                 Icon(Icons.chevron_right, color: Colors.grey.shade400),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:farmhouse_app/views/contact/contact_screen.dart';
import 'package:farmhouse_app/views/location/location_screen.dart';
import 'package:farmhouse_app/views/notifications/notification_screen.dart';
import 'package:farmhouse_app/views/privacy/privacy_policy.dart';
import 'package:farmhouse_app/views/privacy/terms_conditions.dart';
import 'package:farmhouse_app/views/profile/edit_profile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top section with background image and profile
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Background image container
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1540553016722-983e48a2cd10?w=800',
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),

                // Top icons
                // SafeArea(
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Container(
                //           padding: const EdgeInsets.all(8),
                //           decoration: BoxDecoration(
                //             color: Colors.white.withOpacity(0.2),
                //             shape: BoxShape.circle,
                //           ),
                //           child: const Icon(
                //             Icons.favorite_border,
                //             color: Colors.white,
                //             size: 20,
                //           ),
                //         ),
                //         const SizedBox(width: 12),
                //         Container(
                //           padding: const EdgeInsets.all(8),
                //           decoration: BoxDecoration(
                //             color: Colors.red,
                //             shape: BoxShape.circle,
                //           ),
                //           child: const Icon(
                //             Icons.bookmark,
                //             color: Colors.white,
                //             size: 20,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // Profile picture
                Positioned(
                  bottom: -50,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://media.newyorker.com/photos/5909527c1c7a8e33fb38a864/master/pass/Man_of_Steel-580.jpeg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            // Name
            const Text(
              'Melvin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            // Quote
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'Work hard in silence, let your success be the noise',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.3),
              ),
            ),

            const SizedBox(height: 30),

            // Menu items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'My Location',
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: 'Account',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy',
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon:Icons.article,
                    title: 'Terms & Conditions',
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TermsConditions()),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.group,
                    title: 'Contact Us',
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 20, color: Colors.grey.shade600),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
