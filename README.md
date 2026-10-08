<div align="center">

# 🐝 Bee Queen Scanner 👑

**Real-time AI-Powered Queen Bee Detection for Mobile Devices**

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![YOLOv11](https://img.shields.io/badge/YOLOv11-Real--Time-yellow?style=for-the-badge&logo=ultralytics)](https://github.com/ultralytics/ultralytics)
[![TFLite](https://img.shields.io/badge/TFLite-Mobile%20Inference-orange?style=for-the-badge&logo=tensorflow)](https://tensorflow.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/amine2077/Bee-Queen-Scanner?style=for-the-badge&color=gold)](https://github.com/amine2077/Bee-Queen-Scanner/stargazers)

<p align="center">
  <a href="#-features">Features</a> •
  <a href="#-tech-stack">Tech Stack</a> •
  <a href="#-getting-started">Getting Started</a> •
  <a href="#-architecture">Architecture</a> •
  <a href="#-contributing">Contributing</a> •
  <a href="#-license">License</a>
</p>

---

</div>

## 📌 Overview

**Bee Queen Scanner** is a cutting-edge, mobile computer vision application built with **Flutter** and **YOLO (You Only Look Once)** deep learning models. Designed for beekeepers, researchers, and apiary enthusiasts, it identifies queen bees in real-time straight through your smartphone camera.

---

## ✨ Features

- 🔍 **Real-Time Detection**: On-device AI detection running at high FPS.
- ⚡ **Multi-Model Selector**: Switch between standard float32, INT8 quantized, and custom YOLO variants.
- 🔊 **Audio Alerts**: Instant sound notification upon queen bee identification.
- 🎚️ **Live Confidence Slider**: Adjust detection thresholds dynamically on-screen.
- 📸 **Frame Capture & Review**: Pause and inspect detection frames effortlessly.
- 📊 **Performance HUD**: Monitor real-time inference time (ms) and bounding box confidence score.

---

## 🛠️ Tech Stack

| Component | Technology |
| :--- | :--- |
| **Framework** | [Flutter 3.x](https://flutter.dev/) (Dart) |
| **ML Engine** | [ultralytics_yolo](https://pub.dev/packages/ultralytics_yolo) (TensorFlow Lite) |
| **Model** | Custom Trained YOLO Object Detection |
| **Audio Alert** | [audioplayers](https://pub.dev/packages/audioplayers) |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.11.5`)
- Physical **Android** or **iOS** device with a working camera *(Emulators do not support live ML camera streams)*.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/amine2077/Bee-Queen-Scanner.git
   cd Bee-Queen-Scanner
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run on connected device:**
   ```bash
   flutter run --release
   ```

---

## 📂 Project Architecture

```
Bee-Queen-Scanner/
├── assets/
│   ├── models/            # Quantized & FP32 TFLite YOLO models
│   ├── image/             # App branding & logo graphics
│   └── sounds/            # Alert sound clips
├── lib/
│   ├── main.dart          # Camera view, YOLO bounding box overlay & HUD
│   └── about_screen.dart  # Info & app documentation UI
├── CONTRIBUTING.md        # Contribution guidelines
├── LICENSE                # MIT License
└── README.md              # Project documentation
```

---

## 📸 Screenshots & Demo

> *Tip: Record a short clip or screenshot of the app running on your phone and place it in `assets/image/demo.gif`!*

| Live Detection UI | About & Model Selector |
| :---: | :---: |
| *(Add your screenshot/GIF here)* | *(Add your screenshot/GIF here)* |

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!  
Feel free to check out the [issues page](https://github.com/amine2077/Bee-Queen-Scanner/issues) or read our [Contributing Guide](CONTRIBUTING.md).

---

## 📄 License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for more details.

---

<div align="center">
  <sub>Built with ❤️ for Beekeepers & AI Community by <a href="https://github.com/amine2077">amine2077</a></sub>
</div>
