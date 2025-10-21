// import 'package:flutter/material.dart';

// void main() {
//   runApp(ClipRectDemoApp());
// }

// class ClipRectDemoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ClipRect Demo',
//       home: ClipRectDemoScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class ClipRectDemoScreen extends StatefulWidget {
//   @override
//   _ClipRectDemoScreenState createState() => _ClipRectDemoScreenState();
// }

// class _ClipRectDemoScreenState extends State<ClipRectDemoScreen> {
//   double _clipFactor = 0.5; // Controls width/height factor

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ClipRect Demo'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Full image for reference
//             Text('Full Image'),
//             SizedBox(height: 8),
//             Image.network('https://picsum.photos/200'),

//             SizedBox(height: 24),

//             // Clipped image
//             Text('Clipped Image'),
//             SizedBox(height: 8),
//             ClipRect(
//               clipBehavior: Clip.hardEdge, // Property #2 to demo
//               child: Align(
//                 alignment: Alignment.center,
//                 widthFactor: _clipFactor,
//                 heightFactor: _clipFactor, // Property #3 to demo
//                 child: Image.network('https://picsum.photos/200'), // Property #1
//               ),
//             ),

//             SizedBox(height: 24),

//             // Slider to adjust visible area
//             Text('Adjust Clip Size'),
//             Slider(
//               value: _clipFactor,
//               min: 0.1,
//               max: 1.0,
//               divisions: 9,
//               label: _clipFactor.toStringAsFixed(1),
//               onChanged: (value) {
//                 setState(() {
//                   _clipFactor = value;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }







// import 'package:flutter/material.dart';

// void main() {
//   runApp(ClipDemoApp());
// }

// class ClipDemoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Clip Demo',
//       debugShowCheckedModeBanner: false,
//       home: ClipDemoScreen(),
//     );
//   }
// }

// class ClipDemoScreen extends StatefulWidget {
//   @override
//   _ClipDemoScreenState createState() => _ClipDemoScreenState();
// }

// class _ClipDemoScreenState extends State<ClipDemoScreen> {
//   String _selectedClip = 'None';
//   double _clipFactor = 1.0; // For ClipRect width/height factor
//   double _borderRadius = 50; // For ClipRRect

//   final List<String> _images = [
//     'assets/pizzaphoto.jpg',
//     'assets/photo3.webp',
//     'assets/flutterphoto.jpg',
//   ];

//   int _currentImageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Clip Demo'),
//         backgroundColor: Colors.purple,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               'Clip with: $_selectedClip',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             SizedBox(height: 16),

//             // Carousel of images
//             Expanded(
//               child: PageView.builder(
//                 itemCount: _images.length,
//                 controller: PageController(viewportFraction: 0.8),
//                 onPageChanged: (index) {
//                   setState(() {
//                     _currentImageIndex = index;
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   return _buildClippedImage(_images[index]);
//                 },
//               ),
//             ),

//             SizedBox(height: 16),

//             // Slider for ClipRect or ClipRRect
//             if (_selectedClip == 'ClipRect')
//               Column(
//                 children: [
//                   Text('Adjust width/height factor: ${_clipFactor.toStringAsFixed(1)}'),
//                   Slider(
//                     value: _clipFactor,
//                     min: 0.1,
//                     max: 1.0,
//                     divisions: 9,
//                     onChanged: (value) {
//                       setState(() {
//                         _clipFactor = value;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             if (_selectedClip == 'ClipRRect')
//               Column(
//                 children: [
//                   Text('Adjust border radius: ${_borderRadius.toInt()}'),
//                   Slider(
//                     value: _borderRadius,
//                     min: 0,
//                     max: 150,
//                     divisions: 15,
//                     onChanged: (value) {
//                       setState(() {
//                         _borderRadius = value;
//                       });
//                     },
//                   ),
//                 ],
//               ),

//             SizedBox(height: 16),

//             // Clip selection buttons
//             Wrap(
//               spacing: 10,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _selectedClip = 'ClipRect';
//                     });
//                   },
//                   child: Text('ClipRect'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _selectedClip = 'ClipRRect';
//                     });
//                   },
//                   child: Text('ClipRRect'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _selectedClip = 'ClipOval';
//                     });
//                   },
//                   child: Text('ClipOval'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       _selectedClip = 'ClipPath';
//                     });
//                   },
//                   child: Text('ClipPath'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildClippedImage(String imagePath) {
//     Widget imageWidget = Image.asset(
//       imagePath,
//       width: 350,
//       height: 350,
//       fit: BoxFit.cover,
//     );

//     Widget clipped;

//     switch (_selectedClip) {
//       case 'ClipRect':
//         clipped = ClipRect(
//           child: Align(
//             alignment: Alignment.center,
//             widthFactor: _clipFactor,
//             heightFactor: _clipFactor,
//             child: imageWidget,
//           ),
//         );
//         break;
//       case 'ClipRRect':
//         clipped = ClipRRect(
//           borderRadius: BorderRadius.circular(_borderRadius),
//           child: imageWidget,
//         );
//         break;
//       case 'ClipOval':
//         clipped = ClipOval(child: imageWidget);
//         break;
//       case 'ClipPath':
//         clipped = ClipPath(
//           clipper: TriangleClipper(),
//           child: imageWidget,
//         );
//         break;
//       default:
//         clipped = imageWidget;
//     }

//     return Card(
//       elevation: 6,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       child: Container(
//         padding: EdgeInsets.all(12),
//         child: clipped,
//       ),
//     );
//   }
// }

// // Triangle clipper for ClipPath demo
// class TriangleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(size.width / 2, 0);
//     path.lineTo(0, size.height);
//     path.lineTo(size.width, size.height);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }






import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/tap_focus_screen.dart';
import 'screens/clipping_demo_screen.dart';

void main() {
  runApp(const ClipDemoApp());
}

class ClipDemoApp extends StatelessWidget {
  const ClipDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clip Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/tap-focus': (context) => const TapFocusScreen(),
        '/clipping-demo': (context) => const ClippingDemoScreen(),
      },
    );
  }
}