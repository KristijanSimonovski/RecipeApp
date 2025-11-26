import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeYoutubeButton extends StatelessWidget {
  final String url;

  const RecipeYoutubeButton({super.key, required this.url});

  Future<void> _openLink() async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }


  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _openLink,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      label: const Text("YouTube Tutorial"),
    );
  }
}
