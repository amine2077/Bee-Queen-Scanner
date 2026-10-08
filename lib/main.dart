import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';
import 'package:audioplayers/audioplayers.dart';
import 'about_screen.dart';

void main() {
  runApp(const BeeScannerTestApp());
}

class BeeScannerTestApp extends StatelessWidget {
  const BeeScannerTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bee Scanner YOLO Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const DetectionScreen(),
    );
  }
}

class DetectionScreen extends StatefulWidget {
  const DetectionScreen({super.key});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  final YOLOViewController _controller = YOLOViewController();
  final AudioPlayer _player = AudioPlayer();

  bool _isAlertActive = false;

  static const Map<String, String> _models = {
    'Queen Bee (custom)': 'assets/models/best.tflite',
    'Queen Bee (int8)': 'assets/models/best_int8.tflite',
    'YOLO26n (official)': 'yolo26n',
  };

  String _activeModelLabel = 'Queen Bee (custom)';
  double _confidenceThreshold = 0.25;
  double _detectionTimeMs = 0.0;
  int _detectionCount = 0;
  bool _modelReady = false;
  String? _statusMessage;
  late final String _cameraResolution = '1080p';

  @override
  void dispose() {
    _player.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onResult(List<YOLOResult> results) {
    if (!mounted) return;
    final hasQueen = results.any(
      (r) => r.className.toLowerCase().contains('queen'),
    );
    if (hasQueen && !_isAlertActive) {
      _isAlertActive = true;
      _player.setSource(AssetSource('sounds/bee_dedection.mp3'));
      _player.setReleaseMode(ReleaseMode.loop);
      _player.resume();
    } else if (!hasQueen && _isAlertActive) {
      _isAlertActive = false;
      _player.stop();
    }
    setState(() {
      _detectionCount = results.length;
      if (_statusMessage != null && _modelReady) {
        _statusMessage = null;
      }
    });
  }

  void _onPerformanceMetrics(YOLOPerformanceMetrics metrics) {
    if (!mounted) return;
    setState(() {
      _detectionTimeMs = metrics.processingTimeMs;
    });
  }

  void _onModelLoad(String modelPath, YOLOTask? task) {
    if (!mounted) return;
    setState(() {
      _modelReady = true;
      _statusMessage = null;
    });
  }

  void _onModelError(Object error, String modelPath, YOLOTask? task) {
    if (!mounted) return;
    setState(() {
      _modelReady = false;
      _statusMessage = 'Model error: $error';
    });
  }

  Future<void> _switchModel(String label) async {
    final modelPath = _models[label]!;
    setState(() {
      _activeModelLabel = label;
      _modelReady = false;
      _statusMessage = 'Loading $label...';
      _detectionCount = 0;
    });
    try {
      await _controller.switchModel(modelPath);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _statusMessage = 'Switch to $label failed: $e';
      });
    }
  }

  void _onConfidenceChanged(double value) {
    setState(() {
      _confidenceThreshold = value;
    });
    _controller.setConfidenceThreshold(value);
  }

  Future<void> _captureFrame() async {
    try {
      final bytes = await _controller.captureFrame();
      if (bytes == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Capture returned no data')),
        );
        return;
      }
      if (!mounted) return;
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.memory(bytes),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Detections: $_detectionCount | ${_detectionTimeMs.toStringAsFixed(1)}ms',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Capture failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          YOLOView(
            cameraResolution: _cameraResolution,
            modelPath: _models[_activeModelLabel]!,
            task: YOLOTask.detect,
            controller: _controller,
            confidenceThreshold: _confidenceThreshold,
            streamingConfig: const YOLOStreamingConfig(
              analysisResolution: Size(1920, 1080),
            ),
            onResult: _onResult,
            onPerformanceMetrics: _onPerformanceMetrics,
            onModelLoad: _onModelLoad,
            onModelError: _onModelError,
            lensFacing: LensFacing.back,
          ),
          if (_statusMessage != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _statusMessage!,
                  style: const TextStyle(color: Colors.yellow, fontSize: 13),
                ),
              ),
            ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            right: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildModelDropdown(),
                    const Spacer(),
                    _buildBranding(),
                  ],
                ),

              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 16,
            left: 16,
            right: 16,
            child: _buildBottomControls(),
          ),
        ],
      ),
    );
  }

  Widget _buildModelDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _activeModelLabel,
          dropdownColor: Colors.black87,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          items: _models.keys.map((label) {
            return DropdownMenuItem(
              value: label,
              child: Text(label),
            );
          }).toList(),
          onChanged: (label) {
            if (label != null && label != _activeModelLabel) {
              _switchModel(label);
            }
          },
        ),
      ),
    );
  }

  Widget _buildBranding() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'BQS',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.amber,
          letterSpacing: 1.5,
        ),
      ),
    );
  }


  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.timer_outlined,
                  color: _detectionTimeMs > 100 ? Colors.orange : Colors.green,
                  size: 16),
              const SizedBox(width: 4),
              Text(
                '${_detectionTimeMs.toStringAsFixed(1)} ms',
                style: TextStyle(
                  color: _detectionTimeMs > 100 ? Colors.orange : Colors.green,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.category_outlined,
                  color: _detectionCount > 0 ? Colors.lightBlue : Colors.white38,
                  size: 16),
              const SizedBox(width: 4),
              Text(
                '$_detectionCount detections',
                style: TextStyle(
                  color: _detectionCount > 0 ? Colors.lightBlue : Colors.white38,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.info_outline,
                    color: Colors.white70, size: 22),
                onPressed: () async {
                  await _controller.pause();
                  if (!mounted) return;
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AboutScreen()),
                  );
                  if (!mounted) return;
                  await _controller.resume();
                },
                tooltip: 'About',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Icons.camera_alt_outlined,
                    color: Colors.white70, size: 22),
                onPressed: _captureFrame,
                tooltip: 'Save frame',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text('Conf:',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              Expanded(
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 3,
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 7),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 14),
                  ),
                  child: Slider(
                    value: _confidenceThreshold,
                    min: 0.1,
                    max: 0.9,
                    divisions: 16,
                    label: _confidenceThreshold.toStringAsFixed(2),
                    onChanged: _onConfidenceChanged,
                  ),
                ),
              ),
              SizedBox(
                width: 36,
                child: Text(
                  _confidenceThreshold.toStringAsFixed(2),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
