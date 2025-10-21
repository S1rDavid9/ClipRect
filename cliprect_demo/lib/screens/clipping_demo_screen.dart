import 'package:flutter/material.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/clip_image_card.dart';

class ClippingDemoScreen extends StatefulWidget {
  const ClippingDemoScreen({Key? key}) : super(key: key);

  @override
  State<ClippingDemoScreen> createState() => _ClippingDemoScreenState();
}

class _ClippingDemoScreenState extends State<ClippingDemoScreen> {
  String _selectedClip = 'ClipRect';
  double _clipFactor = 1.0;
  double _borderRadius = 50;
  int _currentImageIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.purple[50]!],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const BackButtonWidget(),
                      const SizedBox(width: 16),
                      const Text(
                        'Clipping Types Demo',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blue],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.crop, color: Colors.white),
                      const SizedBox(width: 12),
                      Text(
                        'Current: $_selectedClip',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Image carousel
                SizedBox(
                  height: 400,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return AnimatedScale(
                        scale: index == _currentImageIndex ? 1.0 : 0.9,
                        duration: const Duration(milliseconds: 300),
                        child: ClipImageCard(
                          clipType: _selectedClip,
                          clipFactor: _clipFactor,
                          borderRadius: _borderRadius,
                          imageIndex: index,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Page indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: index == _currentImageIndex ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: index == _currentImageIndex
                            ? Colors.purple
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Sliders
                if (_selectedClip == 'ClipRect') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Text(
                          'Clip Factor: ${_clipFactor.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Slider(
                          value: _clipFactor,
                          min: 0.1,
                          max: 1.0,
                          divisions: 18,
                          activeColor: Colors.purple,
                          onChanged: (value) {
                            setState(() {
                              _clipFactor = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
                if (_selectedClip == 'ClipRRect') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Text(
                          'Border Radius: ${_borderRadius.toInt()}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Slider(
                          value: _borderRadius,
                          min: 0,
                          max: 150,
                          divisions: 15,
                          activeColor: Colors.blue,
                          onChanged: (value) {
                            setState(() {
                              _borderRadius = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _buildClipButton('ClipRect', Icons.crop_square,
                          [Colors.purple, Colors.deepPurple]),
                      const SizedBox(width: 10),
                      _buildClipButton('ClipRRect', Icons.crop_7_5,
                          [Colors.blue, Colors.indigo]),
                      const SizedBox(width: 10),
                      _buildClipButton(
                          'ClipOval', Icons.circle, [Colors.pink, Colors.red]),
                      const SizedBox(width: 10),
                      _buildClipButton('ClipPath', Icons.change_history,
                          [Colors.orange, Colors.deepOrange]),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClipButton(
      String label, IconData icon, List<Color> gradientColors) {
    final isSelected = _selectedClip == label;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedClip = label;
          });
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          backgroundColor: isSelected ? gradientColors[0] : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black87,
          elevation: isSelected ? 8 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: gradientColors[0],
              width: 2,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}