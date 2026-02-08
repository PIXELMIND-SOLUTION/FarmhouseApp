// import 'package:farmhouse_app/provider/auth/profile_provider.dart';
// import 'package:farmhouse_app/provider/auth/register_provider.dart';
// import 'package:farmhouse_app/provider/firebase/google_provider.dart';
// import 'package:farmhouse_app/views/Deleteaccount/delete_account.dart';
// import 'package:farmhouse_app/views/auth/login_screen.dart';
// import 'package:farmhouse_app/views/contact/contact_screen.dart';
// import 'package:farmhouse_app/views/location/location_screen.dart';
// import 'package:farmhouse_app/views/notifications/notification_screen.dart';
// import 'package:farmhouse_app/views/privacy/privacy_policy.dart';
// import 'package:farmhouse_app/views/privacy/terms_conditions.dart';
// import 'package:farmhouse_app/views/profile/edit_profile.dart';
// import 'package:farmhouse_app/views/reviews/review_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _loadProfileData();
//   }

//   Future<void> _loadProfileData() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     await authProvider.loadUserFromPrefs();

//     final user = authProvider.user;
//     final googleAuthProvider = Provider.of<GoogleAuthenticationProvider>(
//       context,
//       listen: false,
//     );
//     final googleUser = googleAuthProvider.user;

//     if (user != null) {
//       final profileProvider = Provider.of<ProfileProvider>(
//         context,
//         listen: false,
//       );
//       await profileProvider.fetchProfile(user.id);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     final profileProvider = Provider.of<ProfileProvider>(context);
//     final googleAuthProvider = Provider.of<GoogleAuthenticationProvider>(
//       context,
//     );

//     final user = authProvider.user;
//     final googleUser = googleAuthProvider.user;
//     final profileData = profileProvider.profileData;

//     String displayName = "Guest User";
//     if (googleUser?.displayName != null) {
//       displayName = googleUser!.displayName!;
//     } else if (profileData != null && profileData['fullName'] != null) {
//       displayName = profileData['fullName'];
//     } else if (user != null) {
//       displayName = "${user.firstName} ${user.lastName}";
//     }

//     String? profileImageUrl;
//     if (googleUser?.photoURL != null) {
//       profileImageUrl = googleUser!.photoURL;
//     } else if (profileData != null && profileData['profileImage'] != null) {
//       profileImageUrl = profileData['profileImage'];
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: RefreshIndicator(
//         onRefresh: _loadProfileData,
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   // Container(
//                   //   height: 300,
//                   //   decoration: BoxDecoration(
//                   //     image: DecorationImage(
//                   //       image: NetworkImage(
//                   //         'https://images.unsplash.com/photo-1540553016722-983e48a2cd10?w=800',
//                   //       ),
//                   //       fit: BoxFit.cover,
//                   //       colorFilter: ColorFilter.mode(
//                   //         Colors.black.withOpacity(0.3),
//                   //         BlendMode.darken,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   Container(
//                     height: 300,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: profileImageUrl != null
//                             ? NetworkImage(profileImageUrl)
//                             : const NetworkImage(
//                                 'https://images.unsplash.com/photo-1540553016722-983e48a2cd10?w=800',
//                               ),
//                         fit: BoxFit.cover,
//                         colorFilter: ColorFilter.mode(
//                           Colors.black.withOpacity(0.3),
//                           BlendMode.darken,
//                         ),
//                       ),
//                     ),
//                   ),

//                   // Container(
//                   //   height: 300,
//                   //   decoration: BoxDecoration(
//                   //     image: DecorationImage(
//                   //       image:
//                   //           profileData != null &&
//                   //               profileData['profileImage'] != null &&
//                   //               profileData['profileImage']
//                   //                   .toString()
//                   //                   .isNotEmpty
//                   //           ? NetworkImage(
//                   //               profileData['profileImage'],
//                   //             ) // ✅ User profile image
//                   //           : const NetworkImage(
//                   //               'https://images.unsplash.com/photo-1540553016722-983e48a2cd10?w=800',
//                   //             ), // ✅ Default image
//                   //       fit: BoxFit.cover,
//                   //       colorFilter: ColorFilter.mode(
//                   //         Colors.black.withOpacity(0.3),
//                   //         BlendMode.darken,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   Positioned(
//                     bottom: -50,
//                     left: MediaQuery.of(context).size.width / 2 - 50,
//                     child: Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 4),
//                         color: Colors.grey.shade200,
//                       ),
//                       child: ClipOval(
//                         child: profileImageUrl != null
//                             ? Image.network(
//                                 profileImageUrl,
//                                 fit: BoxFit.cover,
//                                 loadingBuilder:
//                                     (context, child, loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return Center(
//                                         child: CircularProgressIndicator(
//                                           value:
//                                               loadingProgress
//                                                       .expectedTotalBytes !=
//                                                   null
//                                               ? loadingProgress
//                                                         .cumulativeBytesLoaded /
//                                                     loadingProgress
//                                                         .expectedTotalBytes!
//                                               : null,
//                                           strokeWidth: 2,
//                                         ),
//                                       );
//                                     },
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return const Icon(
//                                     Icons.person,
//                                     size: 50,
//                                     color: Colors.grey,
//                                   );
//                                 },
//                               )
//                             : const Icon(
//                                 Icons.person,
//                                 size: 50,
//                                 color: Colors.grey,
//                               ),
//                       ),
//                       // child: ClipOval(
//                       //   child:
//                       //       profileData != null &&
//                       //           profileData['profileImage'] != null
//                       //       ? Image.network(
//                       //           profileData['profileImage'],
//                       //           fit: BoxFit.cover,
//                       //           loadingBuilder:
//                       //               (context, child, loadingProgress) {
//                       //                 if (loadingProgress == null) return child;
//                       //                 return Center(
//                       //                   child: CircularProgressIndicator(
//                       //                     value:
//                       //                         loadingProgress
//                       //                                 .expectedTotalBytes !=
//                       //                             null
//                       //                         ? loadingProgress
//                       //                                   .cumulativeBytesLoaded /
//                       //                               loadingProgress
//                       //                                   .expectedTotalBytes!
//                       //                         : null,
//                       //                     strokeWidth: 2,
//                       //                   ),
//                       //                 );
//                       //               },
//                       //           errorBuilder: (context, error, stackTrace) {
//                       //             return const Icon(
//                       //               Icons.person,
//                       //               size: 50,
//                       //               color: Colors.grey,
//                       //             );
//                       //           },
//                       //         )
//                       //       : const Icon(
//                       //           Icons.person,
//                       //           size: 50,
//                       //           color: Colors.grey,
//                       //         ),
//                       // ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 60),

//               // Text(
//               //   profileData != null && profileData['fullName'] != null
//               //       ? profileData['fullName']
//               //       : user != null
//               //       ? "${user.firstName} ${user.lastName}"
//               //       : "Guest User",
//               //   style: const TextStyle(
//               //     fontSize: 24,
//               //     fontWeight: FontWeight.w600,
//               //     color: Colors.black,
//               //   ),
//               // ),
//               Text(
//                 displayName,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),

//               // const SizedBox(height: 4),
//               // if (profileData != null && profileData['username'] != null)
//               //   Text(
//               //     '@${profileData['username']}',
//               //     style: TextStyle(
//               //       fontSize: 14,
//               //       fontWeight: FontWeight.w400,
//               //       color: Colors.grey.shade600,
//               //     ),
//               //   ),
//               const SizedBox(height: 4),

//               // Text(
//               //   profileData != null && profileData['phoneNumber'] != null
//               //       ? profileData['phoneNumber']
//               //       : user != null
//               //       ? user.phoneNumber
//               //       : "123456789",
//               //   style: const TextStyle(
//               //     fontSize: 16,
//               //     fontWeight: FontWeight.bold,
//               //     color: Colors.black87,
//               //   ),
//               // ),
//               Text(
//                 googleUser?.email ??
//                     (profileData != null && profileData['phoneNumber'] != null
//                         ? profileData['phoneNumber']
//                         : user?.phoneNumber ?? "No contact info"),
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 50),
//                 child: Text(
//                   'Work hard in silence, let your success be the noise',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey,
//                     height: 1.3,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     _buildMenuItem(
//                       icon: Icons.location_on_outlined,
//                       title: 'My Location',
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 LocationScreen(userId: user!.id),
//                           ),
//                         );
//                       },
//                     ),
//                     _buildMenuItem(
//                       icon: Icons.person_outline,
//                       title: 'Account',
//                       onTap: () async {
//                         final result = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => EditProfile(),
//                           ),
//                         );

//                         // Reload profile data if edit was successful
//                         if (result == true) {
//                           _loadProfileData();
//                         }
//                       },
//                     ),
//                     _buildMenuItem(
//                       icon: Icons.notifications_none,
//                       title: 'Notifications',
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => NotificationScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                     _buildMenuItem(
//                       icon: Icons.privacy_tip,
//                       title: 'Privacy Policy',
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PrivacyPolicy(),
//                           ),
//                         );
//                       },
//                     ),
//                     _buildMenuItem(
//                       icon: Icons.article,
//                       title: 'Terms & Conditions',
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => TermsConditions(),
//                           ),
//                         );
//                       },
//                     ),

//                     _buildMenuItem(
//                       icon: Icons.delete,
//                       title: 'Delete Account',
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DeleteAccount(),
//                           ),
//                         );
//                       },
//                     ),
//                     // _buildMenuItem(
//                     //   icon: Icons.star_border_outlined,
//                     //   title: 'Reviews',
//                     //   onTap: () {
//                     //     Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(
//                     //         builder: (context) => ReviewScreen(),
//                     //       ),
//                     //     );
//                     //   },
//                     // ),
//                     _buildMenuItem(
//                       icon: Icons.group,
//                       title: 'Contact Us',
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 ContactScreen(userId: authProvider.user!.id),
//                           ),
//                         );
//                       },
//                     ),
//                     _buildMenuItem(
//                       icon: Icons.exit_to_app,
//                       title: 'Logout',
//                       onTap: () {
//                         _showLogoutDialog(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showLogoutDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Logout"),
//         content: const Text(
//           "Are you sure you want to logout from your account?",
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Provider.of<AuthProvider>(context, listen: false).logout();
//             //   final googleAuthProvider = Provider.of<GoogleAuthenticationProvider>(
//             //   context,
//             //   listen: false,
//             // );
//             //  googleAuthProvider.signOut(); //
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   backgroundColor: Colors.red,
//                   content: Text('Logged out Successfully'),
//                 ),
//               );
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginScreen()),
//                 (route) => false,
//               );
//             },
//             child: const Text("Logout"),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMenuItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade200, width: 1),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(8),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           child: Row(
//             children: [
//               Icon(icon, size: 20, color: Colors.grey.shade600),
//               const SizedBox(width: 16),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black87,
//                 ),
//               ),
//               const Spacer(),
//               Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
















import 'package:farmhouse_app/provider/auth/profile_provider.dart';
import 'package:farmhouse_app/provider/auth/register_provider.dart';
import 'package:farmhouse_app/provider/firebase/google_provider.dart';
import 'package:farmhouse_app/views/Deleteaccount/delete_account.dart';
import 'package:farmhouse_app/views/auth/login_screen.dart';
import 'package:farmhouse_app/views/location/location_screen.dart';
import 'package:farmhouse_app/views/notifications/notification_screen.dart';
import 'package:farmhouse_app/views/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadUserFromPrefs();

    final user = authProvider.user;
    final googleAuthProvider = Provider.of<GoogleAuthenticationProvider>(
      context,
      listen: false,
    );
    final googleUser = googleAuthProvider.user;

    if (user != null) {
      final profileProvider = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      await profileProvider.fetchProfile(user.id);
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open the link'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    final googleAuthProvider = Provider.of<GoogleAuthenticationProvider>(
      context,
    );

    final user = authProvider.user;
    final googleUser = googleAuthProvider.user;
    final profileData = profileProvider.profileData;

    String displayName = "Guest User";
    if (googleUser?.displayName != null) {
      displayName = googleUser!.displayName!;
    } else if (profileData != null && profileData['fullName'] != null) {
      displayName = profileData['fullName'];
    } else if (user != null) {
      displayName = "${user.firstName} ${user.lastName}";
    }

    String? profileImageUrl;
    if (googleUser?.photoURL != null) {
      profileImageUrl = googleUser!.photoURL;
    } else if (profileData != null && profileData['profileImage'] != null) {
      profileImageUrl = profileData['profileImage'];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _loadProfileData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: profileImageUrl != null
                            ? NetworkImage(profileImageUrl)
                            : const NetworkImage(
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
                  Positioned(
                    bottom: -50,
                    left: MediaQuery.of(context).size.width / 2 - 50,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        color: Colors.grey.shade200,
                      ),
                      child: ClipOval(
                        child: profileImageUrl != null
                            ? Image.network(
                                profileImageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                          : null,
                                      strokeWidth: 2,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.grey,
                                  );
                                },
                              )
                            : const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Text(
                displayName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                googleUser?.email ??
                    (profileData != null && profileData['phoneNumber'] != null
                        ? profileData['phoneNumber']
                        : user?.phoneNumber ?? "No contact info"),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Work hard in silence, let your success be the noise',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 30),
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
                            builder: (context) =>
                                LocationScreen(userId: user!.id),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: 'Account',
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(),
                          ),
                        );

                        // Reload profile data if edit was successful
                        if (result == true) {
                          _loadProfileData();
                        }
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
                        _launchURL('https://v-farm-houses-policies.onrender.com/privacy-policy');
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.article,
                      title: 'Terms & Conditions',
                      onTap: () {
                        _launchURL('https://v-farm-houses-policies.onrender.com/terms-and-conditions');
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.delete,
                      title: 'Delete Account',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeleteAccount(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.group,
                      title: 'Contact Us',
                      onTap: () {
                        _launchURL('https://v-farm-houses-policies.onrender.com/contact');
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.exit_to_app,
                      title: 'Logout',
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text(
          "Are you sure you want to logout from your account?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<AuthProvider>(context, listen: false).logout();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('Logged out Successfully'),
                ),
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false,
              );
            },
            child: const Text("Logout"),
          ),
        ],
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