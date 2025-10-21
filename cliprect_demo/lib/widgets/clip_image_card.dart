import 'package:flutter/material.dart';

class ClipImageCard extends StatelessWidget {
  final String clipType;
  final double clipFactor;
  final double borderRadius;
  final int imageIndex;

  const ClipImageCard({
    Key? key,
    required this.clipType,
    required this.clipFactor,
    required this.borderRadius,
    required this.imageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: _buildClippedImage(),
        ),
      ),
    );
  }

  Widget _buildClippedImage() {
    final imageWidget = _buildDemoImage();

    switch (clipType) {
      case 'ClipRect':
        return ClipRect(
          child: Align(
            alignment: Alignment.center,
            widthFactor: clipFactor,
            heightFactor: clipFactor,
            child: imageWidget,
          ),
        );
      case 'ClipRRect':
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: imageWidget,
        );
      case 'ClipOval':
        return ClipOval(child: imageWidget);
      case 'ClipPath':
        return ClipPath(
          clipper: TriangleClipper(),
          child: imageWidget,
        );
      default:
        return imageWidget;
    }
  }

  Widget _buildDemoImage() {
    final imageList = [
      'assets/flutterphoto.jpg',
      'assets/photo3.webp',
      'assets/pizzaphoto.jpg',
    ];

    return Image.asset(
      imageList[imageIndex % imageList.length],
      width: 300,
      height: 300,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Fallback gradient if image not found
        final colors = [
          [Colors.orange, Colors.red, Colors.pink],
          [Colors.green, Colors.teal, Colors.blue],
          [Colors.purple, Colors.indigo, Colors.blue],
        ];

        return Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors[imageIndex % colors.length],
            ),
          ),
          child: Center(
            child: Icon(
              imageIndex == 0
                  ? Icons.landscape
                  : imageIndex == 1
                      ? Icons.photo_camera
                      : Icons.image,
              size: 100,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        );
      },
    );
  }
}

// Triangle clipper for ClipPath demo
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}