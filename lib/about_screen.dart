import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool _isArabic = false;

  static const String _appName = 'Bee Queen Scanner';

  static const String _aboutAr =
      'تطبيق Bee Queen Scanner هو تطبيق للكشف عن ملكات النحل باستخدام الذكاء الاصطناعي '
      'لمساعدة النحّالين في التعرف على الملكات داخل الخلية بسرعة ودقة.';

  static const String _aboutEn =
      'Bee Queen Scanner is an AI-powered bee queen detection application '
      'that helps beekeepers identify queens inside the hive quickly and accurately.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    _buildAppName(),
                    const SizedBox(height: 28),
                    _buildDivider(),
                    const SizedBox(height: 20),
                    _buildAboutSection(),
                    const SizedBox(height: 28),
                    _buildDivider(),
                    const SizedBox(height: 20),
                    _buildCallUsSection(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white70),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          IconButton(
            icon: Text(
              _isArabic ? 'EN' : 'AR',
              style: const TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            onPressed: () => setState(() => _isArabic = !_isArabic),
            tooltip: _isArabic ? 'Switch to English' : 'التبديل إلى العربية',
          ),
        ],
      ),
    );
  }

  Widget _buildAppName() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/image/app_image_bee.jpg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _appName,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: Colors.white12,
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isArabic ? 'عن التطبيق' : 'About',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _isArabic ? _aboutAr : _aboutEn,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[300],
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildCallUsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(Icons.phone, color: Colors.green[400], size: 32),
          const SizedBox(height: 8),
          Text(
            _isArabic ? 'اتصل بنا' : 'Call Us',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
