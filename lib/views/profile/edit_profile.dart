// import 'package:flutter/material.dart';

// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   final TextEditingController nameController = TextEditingController(text: 'Albert Florest');
//   final TextEditingController usernameController = TextEditingController(text: 'albertflorest_');
//   final TextEditingController phoneController = TextEditingController(text: '+44 1632 960860');
//   final TextEditingController emailController = TextEditingController(text: 'albertflorest@email.com');
//   String selectedGender = 'Male';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: Container(
//           margin: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFF5A5F),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             Center(
//               child: Stack(
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: const Color(0xFFF5F5F5),
//                       image: const DecorationImage(
//                         image: NetworkImage('https://upload.wikimedia.org/wikipedia/en/thumb/b/bf/Man_of_Steel_Soundtrack_Cover.jpg/250px-Man_of_Steel_Soundtrack_Cover.jpg'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       width: 32,
//                       height: 32,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFFF5A5F),
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 2),
//                       ),
//                       child: IconButton(
//                         padding: EdgeInsets.zero,
//                         icon: const Icon(
//                           Icons.camera_alt,
//                           color: Colors.white,
//                           size: 16,
//                         ),
//                         onPressed: () {
//                           // Image picker action
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 32),
//             _buildLabel('Name'),
//             const SizedBox(height: 8),
//             _buildTextField(nameController),
//             const SizedBox(height: 24),
//             // _buildLabel('Username'),
//             // const SizedBox(height: 8),
//             // _buildTextField(usernameController),
//             // const SizedBox(height: 24),
//             // _buildLabel('Gender'),
//             // const SizedBox(height: 8),
//             // _buildGenderDropdown(),
//             const SizedBox(height: 24),
//             _buildLabel('Phone Number'),
//             const SizedBox(height: 8),
//             _buildTextField(phoneController),
//             const SizedBox(height: 24),
//             _buildLabel('Email'),
//             const SizedBox(height: 8),
//             _buildTextField(emailController),
//             const SizedBox(height: 40),
//             SizedBox(
//               width: double.infinity,
//               height: 56,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Save action
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFFFF5A5F),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: const Text(
//                   'Save',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         color: Color(0xFF424242),
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFF5F5F5),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: TextField(
//         controller: controller,
//         style: const TextStyle(
//           color: Color(0xFF9E9E9E),
//           fontSize: 14,
//         ),
//         decoration: const InputDecoration(
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         ),
//       ),
//     );
//   }

//   // Widget _buildGenderDropdown() {
//   //   return Container(
//   //     decoration: BoxDecoration(
//   //       color: const Color(0xFFF5F5F5),
//   //       borderRadius: BorderRadius.circular(12),
//   //     ),
//   //     padding: const EdgeInsets.symmetric(horizontal: 16),
//   //     child: DropdownButtonHideUnderline(
//   //       child: DropdownButton<String>(
//   //         value: selectedGender,
//   //         isExpanded: true,
//   //         icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
//   //         style: const TextStyle(
//   //           color: Color(0xFF9E9E9E),
//   //           fontSize: 14,
//   //         ),
//   //         items: ['Male', 'Female', 'Other'].map((String value) {
//   //           return DropdownMenuItem<String>(
//   //             value: value,
//   //             child: Text(value),
//   //           );
//   //         }).toList(),
//   //         onChanged: (String? newValue) {
//   //           if (newValue != null) {
//   //             setState(() {
//   //               selectedGender = newValue;
//   //             });
//   //           }
//   //         },
//   //       ),
//   //     ),
//   //   );
//   // }

//   @override
//   void dispose() {
//     nameController.dispose();
//     usernameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }
// }



// import 'dart:io';
// import 'package:farmhouse_app/provider/auth/profile_provider.dart';
// import 'package:farmhouse_app/utils/helper_function.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:share_plus/share_plus.dart';

// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   String selectedGender = 'male';
//   File? _selectedImage;
//   String? _currentImageUrl;
//   String? _userId;
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     _loadProfile();
//   }

//   Future<void> _loadProfile() async {
//     final user = await SharedPrefs.getUser();
//     if (user != null) {
//       _userId = user.id;
//       final provider = Provider.of<ProfileProvider>(context, listen: false);
//       await provider.fetchProfile(user.id);

//       if (provider.profileData != null) {
//         final profile = provider.profileData!;
//         setState(() {
//           nameController.text = profile['fullName'] ?? '';
//           usernameController.text = profile['username'] ?? '';
//           phoneController.text = profile['phoneNumber'] ?? '';
//           emailController.text = profile['email'] ?? '';
//           selectedGender = profile['gender'] ?? 'male';
//           _currentImageUrl = profile['profileImage'];
//         });
//       }
//     }
//   }

//   Future<void> _pickImage() async {
//     try {
//       final XFile? image = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1024,
//         maxHeight: 1024,
//         imageQuality: 85,
//       );

//       if (image != null) {
//         setState(() {
//           _selectedImage = File(image.path);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
//     }
//   }

//   Future<void> _saveProfile() async {
//     if (_userId == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('User ID not found')));
//       return;
//     }

//     final provider = Provider.of<ProfileProvider>(context, listen: false);

//     final success = await provider.updateProfile(
//       userId: _userId!,
//       fullName: nameController.text.trim(),
//       username: usernameController.text.trim(),
//       gender: selectedGender,
//       phoneNumber: phoneController.text.trim(),
//       email: emailController.text.trim(),
//       profileImage: _selectedImage,
//     );

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Profile updated successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       Navigator.pop(context, true);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(provider.errorMessage ?? 'Failed to update profile'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: Container(
//           margin: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFF5A5F),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Consumer<ProfileProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading && provider.profileData == null) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 Center(
//                   child: Stack(
//                     children: [
//                       Container(
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: const Color(0xFFF5F5F5),
//                           image: _selectedImage != null
//                               ? DecorationImage(
//                                   image: FileImage(_selectedImage!),
//                                   fit: BoxFit.cover,
//                                 )
//                               : _currentImageUrl != null
//                               ? DecorationImage(
//                                   image: NetworkImage(_currentImageUrl!),
//                                   fit: BoxFit.cover,
//                                 )
//                               : null,
//                         ),
//                         child:
//                             _selectedImage == null && _currentImageUrl == null
//                             ? const Icon(
//                                 Icons.person,
//                                 size: 50,
//                                 color: Colors.grey,
//                               )
//                             : null,
//                       ),
//                       Positioned(
//                         bottom: 0,
//                         right: 0,
//                         child: Container(
//                           width: 32,
//                           height: 32,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFFF5A5F),
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.white, width: 2),
//                           ),
//                           child: IconButton(
//                             padding: EdgeInsets.zero,
//                             icon: const Icon(
//                               Icons.camera_alt,
//                               color: Colors.white,
//                               size: 16,
//                             ),
//                             onPressed: _pickImage,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 _buildLabel('Name'),
//                 const SizedBox(height: 8),
//                 _buildTextField(nameController),
//                 // const SizedBox(height: 23),
//                 // _buildLabel('Username'),
//                 // const SizedBox(height: 8),
//                 // _buildTextField(usernameController),
//                 // const SizedBox(height: 24),
//                 // _buildLabel('Gender'),
//                 // const SizedBox(height: 8),
//                 // _buildGenderDropdown(),
//                 const SizedBox(height: 24),
//                 // _buildLabel('Phone Number'),
//                 // const SizedBox(height: 8),
//                 // _buildTextField(phoneController),
//                 _buildLabel('Phone Number'),
//                 const SizedBox(height: 8),
//                 _buildTextField(phoneController, readOnly: true),
//                 const SizedBox(height: 24),
//                 // _buildLabel('Email'),
//                 // const SizedBox(height: 8),
//                 // _buildTextField(emailController),
//                 _buildLabel('Email'),
//                 const SizedBox(height: 8),
//                 _buildTextField(emailController, readOnly: true),
//                 const SizedBox(height: 40),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 56,
//                   child: ElevatedButton(
//                     onPressed: provider.isLoading ? null : _saveProfile,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFFF5A5F),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 0,
//                     ),
//                     child: provider.isLoading
//                         ? const SizedBox(
//                             height: 24,
//                             width: 24,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           )
//                         : const Text(
//                             'Save',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildLabel(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         color: Color(0xFF424242),
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }

//   // Widget _buildTextField(TextEditingController controller) {
//   //   return Container(
//   //     decoration: BoxDecoration(
//   //       color: const Color(0xFFF5F5F5),
//   //       borderRadius: BorderRadius.circular(12),
//   //     ),
//   //     child: TextField(
//   //       controller: controller,
//   //       style: const TextStyle(
//   //         color: Color(0xFF424242),
//   //         fontSize: 14,
//   //       ),
//   //       decoration: const InputDecoration(
//   //         border: InputBorder.none,
//   //         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//   //       ),
//   //     ),
//   //   );
//   // }

//   // Widget _buildTextField(
//   //   TextEditingController controller, {
//   //   bool readOnly = false,
//   // }) {
//   //   return Container(
//   //     decoration: BoxDecoration(
//   //       color: const Color(0xFFF5F5F5),
//   //       borderRadius: BorderRadius.circular(12),
//   //     ),
//   //     child: TextField(
//   //       controller: controller,
//   //       readOnly: readOnly,
//   //       enabled: !readOnly,
//   //       style: TextStyle(
//   //         color: readOnly ? Colors.grey : const Color(0xFF424242),
//   //         fontSize: 14,
//   //       ),
//   //       decoration: const InputDecoration(
//   //         border: InputBorder.none,
//   //         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//   //       ),
//   //     ),
//   //   );
//   // }

//   Widget _buildTextField(
//     TextEditingController controller, {
//     bool readOnly = false,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFF5F5F5),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: TextField(
//         controller: controller,
//         readOnly: readOnly,
//         enabled: !readOnly,
//         style: TextStyle(
//           color: readOnly ? Colors.grey : const Color(0xFF424242),
//           fontSize: 14,
//         ),
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 16,
//           ),
//           prefixIcon: readOnly
//               ? const Icon(Icons.lock_outline, size: 20, color: Colors.grey)
//               : null,
//         ),
//       ),
//     );
//   }

//   Widget _buildGenderDropdown() {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFF5F5F5),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: selectedGender,
//           isExpanded: true,
//           icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
//           style: const TextStyle(color: Color(0xFF424242), fontSize: 14),
//           items: ['male', 'female', 'other'].map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(
//                 value.substring(0, 1).toUpperCase() + value.substring(1),
//               ),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             if (newValue != null) {
//               setState(() {
//                 selectedGender = newValue;
//               });
//             }
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     usernameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }
// }














import 'dart:io';
import 'package:farmhouse_app/provider/auth/profile_provider.dart';
import 'package:farmhouse_app/provider/firebase/google_provider.dart';
import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String selectedGender = 'male';
  File? _selectedImage;
  String? _currentImageUrl;
  String? _userId;
  bool _isGoogleUser = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = await SharedPrefs.getUser();
    final googleAuthProvider = Provider.of<GoogleAuthenticationProvider>(context, listen: false);
    final googleUser = googleAuthProvider.user;

    if (googleUser != null) {
      // User is signed in with Google
      setState(() {
        _isGoogleUser = true;
        nameController.text = googleUser.displayName ?? '';
        emailController.text = googleUser.email ?? '';
        phoneController.text = googleUser.phoneNumber ?? '';
        _currentImageUrl = googleUser.photoURL;
      });
    } else if (user != null) {
      // User is signed in with regular auth
      _userId = user.id;
      final provider = Provider.of<ProfileProvider>(context, listen: false);
      await provider.fetchProfile(user.id);

      if (provider.profileData != null) {
        final profile = provider.profileData!;
        setState(() {
          nameController.text = profile['fullName'] ?? '';
          usernameController.text = profile['username'] ?? '';
          phoneController.text = profile['phoneNumber'] ?? '';
          emailController.text = profile['email'] ?? '';
          selectedGender = profile['gender'] ?? 'male';
          _currentImageUrl = profile['profileImage'];
        });
      }
    }
  }

  Future<void> _pickImage() async {
    if (_isGoogleUser) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile picture cannot be changed for Google accounts'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _saveProfile() async {
    if (_isGoogleUser) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Google account profiles cannot be edited here'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID not found')),
      );
      return;
    }

    final provider = Provider.of<ProfileProvider>(context, listen: false);

    final success = await provider.updateProfile(
      userId: _userId!,
      fullName: nameController.text.trim(),
      username: usernameController.text.trim(),
      gender: selectedGender,
      phoneNumber: phoneController.text.trim(),
      email: emailController.text.trim(),
      profileImage: _selectedImage,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? 'Failed to update profile'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFF5A5F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.profileData == null && !_isGoogleUser) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // Profile Picture Section
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFF5F5F5),
                          image: _selectedImage != null
                              ? DecorationImage(
                                  image: FileImage(_selectedImage!),
                                  fit: BoxFit.cover,
                                )
                              : _currentImageUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(_currentImageUrl!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _selectedImage == null && _currentImageUrl == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: _isGoogleUser 
                                ? Colors.grey 
                                : const Color(0xFFFF5A5F),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              _isGoogleUser ? Icons.lock : Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                            onPressed: _pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Google Account Badge
                if (_isGoogleUser) ...[
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Google Account',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 32),
                
                // Name Field
                _buildLabel('Name'),
                const SizedBox(height: 8),
                _buildTextField(nameController, readOnly: _isGoogleUser),
                
                const SizedBox(height: 24),
                
                // Phone Number Field
                _buildLabel('Phone Number'),
                const SizedBox(height: 8),
                _buildTextField(phoneController, readOnly: true),
                
                const SizedBox(height: 24),
                
                // Email Field
                _buildLabel('Email'),
                const SizedBox(height: 8),
                _buildTextField(emailController, readOnly: true),
                
                const SizedBox(height: 40),
                
                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: (_isGoogleUser || provider.isLoading) 
                        ? null 
                        : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5A5F),
                      disabledBackgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: provider.isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            _isGoogleUser 
                                ? 'Google Account (Read Only)' 
                                : 'Save',
                            style: TextStyle(
                              color: _isGoogleUser 
                                  ? Colors.grey.shade600 
                                  : Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF424242),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    bool readOnly = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: readOnly ? Colors.grey.shade100 : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        enabled: !readOnly,
        style: TextStyle(
          color: readOnly ? Colors.grey.shade600 : const Color(0xFF424242),
          fontSize: 14,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          prefixIcon: readOnly
              ? Icon(
                  Icons.lock_outline,
                  size: 20,
                  color: Colors.grey.shade500,
                )
              : null,
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
}