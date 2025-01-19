import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../services/dhikr_service.dart';
import '../services/preferences_service.dart';
import '../models/dhikr.dart';

class AdhkarScreen extends StatelessWidget {
  const AdhkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = DhikrService.getAllDhikrCategories();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'أذكار اليوم',
          style: GoogleFonts.cairo(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ExpansionTile(
              leading: Text(
                category.icon,
                style: const TextStyle(fontSize: 24),
              ),
              title: Text(
                category.name,
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: category.dhikrs
                  .map((dhikr) => DhikrCard(dhikr: dhikr))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

class DhikrCard extends StatefulWidget {
  final Dhikr dhikr;

  const DhikrCard({Key? key, required this.dhikr}) : super(key: key);

  @override
  State<DhikrCard> createState() => _DhikrCardState();
}

class _DhikrCardState extends State<DhikrCard> {
  bool isFavorite = false;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    _loadCounter();
  }

  Future<void> _loadFavoriteStatus() async {
    final favorites = await PreferencesService.getFavorites();
    if (mounted) {
      setState(() {
        isFavorite = favorites.contains(widget.dhikr.text);
      });
    }
  }

  Future<void> _loadCounter() async {
    final counters = await PreferencesService.getCounters();
    if (mounted) {
      setState(() {
        counter = counters[widget.dhikr.text] ?? 0;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    await PreferencesService.toggleFavorite(widget.dhikr.text);
    await _loadFavoriteStatus();
  }

  Future<void> _incrementCounter() async {
    await PreferencesService.incrementCounter(widget.dhikr.text);
    await _loadCounter();
  }

  Future<void> _resetCounter() async {
    await PreferencesService.resetCounter(widget.dhikr.text);
    await _loadCounter();
  }

  void _shareDhikr() {
    Share.share(
      '${widget.dhikr.text}\n\n${widget.dhikr.translation}\n\nالمصدر: ${widget.dhikr.reference}',
      subject: 'مشاركة ذكر',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: _toggleFavorite,
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: _shareDhikr,
              ),
            ],
          ),
          Text(
            widget.dhikr.text,
            style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            widget.dhikr.translation,
            style: GoogleFonts.cairo(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.dhikr.reference,
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              if (widget.dhikr.repeat > 1)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${widget.dhikr.repeat} مرات',
                    style: GoogleFonts.cairo(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _resetCounter,
                tooltip: 'إعادة تعيين العداد',
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$counter/${widget.dhikr.repeat}',
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed:
                    counter < widget.dhikr.repeat ? _incrementCounter : null,
                tooltip: 'زيادة العدد',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
