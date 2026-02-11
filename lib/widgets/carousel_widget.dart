import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  List<String> bannerImages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    const url = "http://31.97.206.144:5124/api/auth/all-banners";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          bannerImages = List<String>.from(data["banners"][0]["images"]);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bannerImages.isEmpty
              ? const Center(child: Text("No banners found"))
              : CarouselSlider(
                  items: bannerImages.map((image) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 40),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 220,
                    autoPlay: true,
                    viewportFraction: 1.0, // Full width
                    enlargeCenterPage: false,
                    autoPlayInterval: const Duration(seconds: 3),
                  ),
                ),
    );
  }
}
