# Bee Queen Scanner 🐝👑

An AI-powered Flutter application for real-time bee queen detection using YOLO (You Only Look Once) object detection models.

## Features

- **Real-time Queen Detection** — Uses custom-trained YOLO models to detect queen bees through the device camera
- **Multiple Model Support** — Switch between different YOLO models (custom float, int8 quantized, official YOLOv26n)
- **Audio Alert** — Plays an alert sound when a queen bee is detected
- **Adjustable Confidence** — Fine-tune the detection confidence threshold with an on-screen slider
- **Frame Capture** — Capture and preview detection frames
- **Performance Metrics** — Real-time display of inference time and detection count

## Tech Stack

- **Framework**: Flutter
- **ML Runtime**: [ultralytics_yolo](https://pub.dev/packages/ultralytics_yolo) (TFLite)
- **Audio**: [audioplayers](https://pub.dev/packages/audioplayers)
- **Models**: Custom-trained YOLO models for queen bee detection

## Getting Started

### Prerequisites

- Flutter SDK ≥ 3.11.5
- Android Studio / Xcode
- A physical device with a camera (emulators do not support real-time camera ML)

### Installation

```bash
git clone https://github.com/YOUR_USERNAME/bee-queen-scanner.git
cd bee-queen-scanner
flutter pub get
flutter run
```

## Project Structure

```
lib/
├── main.dart           # App entry point, camera view & detection UI
└── about_screen.dart   # About / info screen
assets/
├── models/             # YOLO TFLite model files
├── sounds/             # Alert audio files
└── image/              # App images
```

## Screenshots

_Coming soon_

## License

This project is open source.
