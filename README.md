# Flutter ClipRect Widget Demo

A Flutter demonstration app showcasing the **ClipRect** widget through an interactive tap-to-focus photo viewer and clipping types comparison interface.

## 🧩 Widget Description

The `ClipRect` widget clips its child to a rectangular boundary, preventing any overflow and allowing precise control over which portions of a widget are visible. Any part of the child outside this rectangle is not rendered

## 📱 Demo Overview

This app demonstrates ClipRect through two interactive screens:

1. **Tap & Focus Demo** - An interactive photo viewer where tapping any area creates a focused ClipRect window while blurring the background, simulating magnification or detail inspection features found in photo editing and AR apps.

2. **Clipping Types Comparison** - A carousel demonstrating ClipRect alongside ClipRRect, ClipOval, and ClipPath, with live sliders to adjust clipping parameters in real-time.


## 🔑 Three Key Attributes

| Attribute | Description | Demonstration in Code |
|-----------|-------------|----------------------|
| **`child`** | The widget being clipped. ClipRect restricts this child to only display within the rectangular bounds. | In our code, an `Image.asset` serves as the child, and only the selected rectangular area remains visible while the rest is hidden. |
| **`clipBehavior`** | Controls the quality of the clipping edges. Options include `Clip.hardEdge` (fast), `Clip.antiAlias` (smooth), `Clip.antiAliasWithSaveLayer` (highest quality), or `Clip.none`. | We use `Clip.antiAlias` for smooth edges when the focused area zooms in, balancing performance with visual quality. |
| **`Align` with `widthFactor` / `heightFactor`** | While not directly part of ClipRect, the `Align` widget is commonly used with ClipRect to control what portion of the child is visible. Values range from 0.0 (fully clipped) to 1.0 (fully visible). | The slider in the Clipping Types Demo adjusts these factors dynamically, letting users see more or less of the image in real-time. |

### Code Example
```dart
ClipRect(
  clipBehavior: Clip.antiAlias,     // Smooth clipping edges
  child: Align(
    alignment: Alignment.center,    // Center the content
    widthFactor: clipFactor,        // Controls horizontal clipping (0.0-1.0)
    heightFactor: clipFactor,       // Controls vertical clipping (0.0-1.0)
    child: imageWidget,             // The child being clipped
  ),
)
```

**Location in code:** `lib/main.dart` → `ClipImageCard` class → `_buildClippedImage()` method → `case 'ClipRect':`

## 📸 Screenshots

### Home Screen
<img src="C:\Users\Akachi\flutter_mobile_projects\ClipRect\cliprect_demo\screenshots\home_screen.png" width="300">

### Tap & Focus Demo
<img src="C:\Users\Akachi\flutter_mobile_projects\ClipRect\cliprect_demo\screenshots\tapfocus_screen.png" width="300">

### Clipping Types Demo
<img src="C:\Users\Akachi\flutter_mobile_projects\ClipRect\cliprect_demo\screenshots\clipping_screen.png" width="300">

## ⚙️ How to Run

### Prerequisites
- Flutter SDK installed ([Get Flutter](https://flutter.dev/docs/get-started/install))
- An IDE (VS Code, Android Studio, or IntelliJ)
- A device/emulator to run the app

### Steps

1. **Clone the repository:**
```bash
   git clone https://github.com/S1rDavid9/ClipRect.git
```

2. **Navigate to the project:**
```bash
   cd cliprect_demo
```

3. **Get dependencies:**
```bash
   flutter pub get
```

4. **Run the app:**
```bash
   flutter run
```


## 🎨 Features

- ✅ Interactive tap-to-focus with blur effect
- ✅ Real-time clipping adjustment with sliders
- ✅ Comparison of 4 clipping widget types
- ✅ Smooth animations and modern UI
- ✅ Responsive layout for different screen sizes
- ✅ Clean, modular code structure



**Clipping Widgets Demonstrated:**
1. `ClipRect` - Rectangular clipping
2. `ClipRRect` - Rounded rectangle clipping
3. `ClipOval` - Circular/oval clipping
4. `ClipPath` - Custom path clipping (triangle example)


## 👨‍🎓 Author

**Nwanze Akachi David**

Created for an in-class presentation demonstrating Flutter widget implementation and real-world use cases.

## 📝 License

This project is open source and available for educational purposes.

---

**Assignment Submission:** Flutter Widget Presentation - ClipRect

**Date:** 21-10-2025 

**Course:** Mobile Application Development

---


