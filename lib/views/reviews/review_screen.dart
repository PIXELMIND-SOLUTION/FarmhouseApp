// import 'package:flutter/material.dart';

// class ReviewScreen extends StatelessWidget {
//   const ReviewScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F7FB),
//       appBar: AppBar(
//         title: const Text(
//           'Reviews & Ratings',
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           _ratingSummary(),
//           const SizedBox(height: 12),
//           Expanded(child: _reviewList()),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _openWriteReviewModal(context),
//         backgroundColor: const Color(0xFFFF5A5F),
//         icon: const Icon(Icons.rate_review),
//         label: const Text('Write Review'),
//       ),
//     );
//   }

//   /* ---------------- Rating Summary ---------------- */

//   Widget _ratingSummary() {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text(
//                 '4.6',
//                 style: TextStyle(
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 4),
//               Text(
//                 'Based on 128 reviews',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//           const Spacer(),
//           Column(
//             children: [
//               _starRow(4.6),
//               const SizedBox(height: 6),
//               const Text(
//                 'Excellent',
//                 style: TextStyle(
//                   color: Colors.green,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget _starRow(double rating) {
//     return Row(
//       children: List.generate(5, (index) {
//         if (rating >= index + 1) {
//           return const Icon(Icons.star, color: Colors.amber, size: 22);
//         } else if (rating > index && rating < index + 1) {
//           return const Icon(Icons.star_half, color: Colors.amber, size: 22);
//         } else {
//           return const Icon(Icons.star_border, color: Colors.amber, size: 22);
//         }
//       }),
//     );
//   }

//   /* ---------------- Review List ---------------- */

//   Widget _reviewList() {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       itemCount: 5,
//       itemBuilder: (context, index) {
//         return _reviewCard();
//       },
//     );
//   }

//   Widget _reviewCard() {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const CircleAvatar(
//                 radius: 22,
//                 backgroundColor: Color(0xFFE0E7FF),
//                 child: Icon(Icons.person, color: Color(0xFF4A6CF7)),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'John Doe',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       'Verified User',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Text(
//                 '2 days ago',
//                 style: TextStyle(fontSize: 12, color: Colors.grey),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: const [
//               Icon(Icons.star, size: 18, color: Colors.amber),
//               Icon(Icons.star, size: 18, color: Colors.amber),
//               Icon(Icons.star, size: 18, color: Colors.amber),
//               Icon(Icons.star, size: 18, color: Colors.amber),
//               Icon(Icons.star_half, size: 18, color: Colors.amber),
//             ],
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Great experience! The service was smooth and the UI is very easy to use. Highly recommended.',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//               height: 1.4,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /* ---------------- Write Review Modal ---------------- */

//   void _openWriteReviewModal(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       builder: (_) => const _WriteReviewSheet(),
//     );
//   }
// }

// /* ================= Write Review Bottom Sheet ================= */

// class _WriteReviewSheet extends StatefulWidget {
//   const _WriteReviewSheet();

//   @override
//   State<_WriteReviewSheet> createState() => _WriteReviewSheetState();
// }

// class _WriteReviewSheetState extends State<_WriteReviewSheet> {
//   int _rating = 0;
//   final TextEditingController _reviewController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 20,
//         right: 20,
//         top: 20,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Write a Review',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 16),

//           /// Star Rating
//           Row(
//             children: List.generate(5, (index) {
//               return IconButton(
//                 onPressed: () {
//                   setState(() => _rating = index + 1);
//                 },
//                 icon: Icon(
//                   _rating > index ? Icons.star : Icons.star_border,
//                   color: Colors.amber,
//                   size: 32,
//                 ),
//               );
//             }),
//           ),

//           const SizedBox(height: 12),

//           /// Review Field
//           TextField(
//             controller: _reviewController,
//             maxLines: 4,
//             decoration: InputDecoration(
//               hintText: 'Share your experience...',
//               filled: true,
//               fillColor: const Color(0xFFF6F7FB),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           /// Submit Button
//           SizedBox(
//             width: double.infinity,
//             height: 48,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF4A6CF7),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text(
//                 'Submit Review',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }











import 'package:farmhouse_app/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:farmhouse_app/views/models/user_model.dart';

class Review {
  final String userName;
  final String userStatus;
  final double rating;
  final String comment;
  final String timeAgo;

  Review({
    required this.userName,
    required this.userStatus,
    required this.rating,
    required this.comment,
    required this.timeAgo,
  });
}

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  String _currentUserName = 'You';
  
  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final user = await SharedPrefs.getUser();
    if (user != null) {
      setState(() {
        _currentUserName = '${user.firstName} ${user.lastName}'.trim();
        if (_currentUserName.isEmpty) {
          _currentUserName = 'You';
        }
      });
    }
  }

  final List<Review> _reviews = [
    Review(
      userName: 'John Doe',
      userStatus: 'Verified User',
      rating: 4.5,
      comment: 'Great experience! The service was smooth and the UI is very easy to use. Highly recommended.',
      timeAgo: '2 days ago',
    ),
    Review(
      userName: 'Sarah Smith',
      userStatus: 'Verified User',
      rating: 5.0,
      comment: 'Absolutely fantastic! Exceeded my expectations in every way.',
      timeAgo: '3 days ago',
    ),
    Review(
      userName: 'Mike Johnson',
      userStatus: 'Verified User',
      rating: 4.0,
      comment: 'Good service overall. There is room for improvement but satisfied with the experience.',
      timeAgo: '5 days ago',
    ),
    Review(
      userName: 'Emily Davis',
      userStatus: 'Verified User',
      rating: 4.5,
      comment: 'Very professional and responsive. Would definitely recommend to others!',
      timeAgo: '1 week ago',
    ),
    Review(
      userName: 'Alex Brown',
      userStatus: 'Verified User',
      rating: 5.0,
      comment: 'Outstanding quality and excellent customer support. Five stars!',
      timeAgo: '1 week ago',
    ),
  ];

  double get _averageRating {
    if (_reviews.isEmpty) return 0.0;
    double sum = _reviews.fold(0, (prev, review) => prev + review.rating);
    return sum / _reviews.length;
  }

  void _addReview(int rating, String comment) {
    if (rating > 0 && comment.isNotEmpty) {
      setState(() {
        _reviews.insert(
          0,
          Review(
            userName: _currentUserName,
            userStatus: 'Verified User',
            rating: rating.toDouble(),
            comment: comment,
            timeAgo: 'Just now',
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text(
          'Reviews & Ratings',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          _ratingSummary(),
          const SizedBox(height: 12),
          Expanded(child: _reviewList()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openWriteReviewModal(context),
        backgroundColor: const Color(0xFFFF5A5F),
        icon: const Icon(Icons.rate_review),
        label: const Text('Write Review'),
      ),
    );
  }

  /* ---------------- Rating Summary ---------------- */

  Widget _ratingSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Based on ${_reviews.length} reviews',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              _starRow(_averageRating),
              const SizedBox(height: 6),
              Text(
                _getRatingLabel(_averageRating),
                style: TextStyle(
                  color: _getRatingColor(_averageRating),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getRatingLabel(double rating) {
    if (rating >= 4.5) return 'Excellent';
    if (rating >= 4.0) return 'Very Good';
    if (rating >= 3.5) return 'Good';
    if (rating >= 3.0) return 'Average';
    return 'Below Average';
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.5) return Colors.green;
    if (rating >= 4.0) return Colors.lightGreen;
    if (rating >= 3.5) return Colors.orange;
    if (rating >= 3.0) return Colors.orangeAccent;
    return Colors.red;
  }

  static Widget _starRow(double rating) {
    return Row(
      children: List.generate(5, (index) {
        if (rating >= index + 1) {
          return const Icon(Icons.star, color: Colors.amber, size: 22);
        } else if (rating > index && rating < index + 1) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 22);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 22);
        }
      }),
    );
  }

  /* ---------------- Review List ---------------- */

  Widget _reviewList() {
    if (_reviews.isEmpty) {
      return const Center(
        child: Text(
          'No reviews yet. Be the first to review!',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _reviews.length,
      itemBuilder: (context, index) {
        return _reviewCard(_reviews[index]);
      },
    );
  }

  Widget _reviewCard(Review review) {
    final isCurrentUser = review.userName == _currentUserName;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: isCurrentUser
                    ? const Color(0xFFFFE0E0)
                    : const Color(0xFFE0E7FF),
                child: Icon(
                  Icons.person,
                  color: isCurrentUser
                      ? const Color(0xFFFF5A5F)
                      : const Color(0xFF4A6CF7),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review.userStatus,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                review.timeAgo,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _starRow(review.rating),
          const SizedBox(height: 8),
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  /* ---------------- Write Review Modal ---------------- */

  void _openWriteReviewModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _WriteReviewSheet(
        onSubmit: (rating, comment) {
          _addReview(rating, comment);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Review submitted successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
}

/* ================= Write Review Bottom Sheet ================= */

class _WriteReviewSheet extends StatefulWidget {
  final Function(int rating, String comment) onSubmit;

  const _WriteReviewSheet({required this.onSubmit});

  @override
  State<_WriteReviewSheet> createState() => _WriteReviewSheetState();
}

class _WriteReviewSheetState extends State<_WriteReviewSheet> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a rating'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write a review'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    widget.onSubmit(_rating, _reviewController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Write a Review',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          /// Star Rating
          Row(
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () {
                  setState(() => _rating = index + 1);
                },
                icon: Icon(
                  _rating > index ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 32,
                ),
              );
            }),
          ),

          const SizedBox(height: 12),

          /// Review Field
          TextField(
            controller: _reviewController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Share your experience...',
              filled: true,
              fillColor: const Color(0xFFF6F7FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Submit Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A6CF7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Submit Review',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}