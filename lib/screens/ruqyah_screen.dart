import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/audio_item.dart';

class RuqyahScreen extends StatefulWidget {
  const RuqyahScreen({super.key});

  @override
  State<RuqyahScreen> createState() => _RuqyahScreenState();
}

class _RuqyahScreenState extends State<RuqyahScreen>
    with WidgetsBindingObserver {
  late AudioPlayer _audioPlayer;
  AudioItem? _currentlyPlaying;
  bool _isLoading = false;
  bool _isPrepared = false;

  final List<AudioItem> ruqyahAudios = [
    AudioItem(
      title: "الرقية الشرعية للشيخ ماهر المعيقلي",
      url: 'assets/audio/maher.mp3',
      subtitle: 'رقية شفاء من القرآن والسنة',
    ),
    AudioItem(
      title: 'الرقية الشرعية للشيخ ادريس ابكر',
      url: 'assets/audio/Abkar.mp3',
      subtitle: 'رقية شرعية كاملة',
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.stop().then((_) {
      _audioPlayer.dispose();
    });
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _audioPlayer.pause();
    } else if (state == AppLifecycleState.detached) {
      _audioPlayer.stop();
    }
  }

  Future<void> _initAudioPlayer() async {
    _audioPlayer = AudioPlayer();

    // مراقبة حالة التشغيل
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _currentlyPlaying = null;
          _isLoading = false;
          _isPrepared = false;
        });
      }
    });

    // مراقبة الأخطاء
    _audioPlayer.playbackEventStream.listen(
      (event) {
        if (event.processingState == ProcessingState.ready) {
          setState(() {
            _isLoading = false;
            _isPrepared = true;
          });
        }
      },
      onError: (Object e, StackTrace stackTrace) {
        print('خطأ في التشغيل: $e');
        _handlePlaybackError();
      },
    );
  }

  Future<void> _togglePlayPause(AudioItem audio) async {
    try {
      if (_currentlyPlaying?.url == audio.url) {
        if (_audioPlayer.playing) {
          await _audioPlayer.pause();
        } else {
          if (_isPrepared) {
            await _audioPlayer.play();
          } else {
            await _prepareAndPlay(audio);
          }
        }
      } else {
        await _prepareAndPlay(audio);
      }
    } catch (e) {
      print('خطأ في التشغيل: $e');
      _handlePlaybackError();
    }
  }

  Future<void> _prepareAndPlay(AudioItem audio) async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _isPrepared = false;
      _currentlyPlaying = audio;
    });

    try {
      await _audioPlayer.stop();

      if (!mounted) return;

      await _audioPlayer.setAudioSource(
        AudioSource.asset(audio.url),
        initialPosition: Duration.zero,
      );

      if (!mounted) return;

      if (_audioPlayer.processingState == ProcessingState.ready) {
        await _audioPlayer.play();
      }
    } catch (e) {
      print('خطأ في تحضير الملف: $e');
      if (mounted) {
        _handlePlaybackError();
      }
    }
  }

  void _handlePlaybackError() {
    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _isPrepared = false;
      _currentlyPlaying = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('حدث خطأ في تشغيل الملف الصوتي'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _audioPlayer.stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الرقية الشرعية',
            style: GoogleFonts.cairo(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: ruqyahAudios.length,
          itemBuilder: (context, index) {
            final audio = ruqyahAudios[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  audio.title,
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  audio.subtitle ?? '',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: _buildPlayButton(audio),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayButton(AudioItem audio) {
    return StreamBuilder<PlayerState>(
      stream: _audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final isCurrentTrack = _currentlyPlaying?.url == audio.url;

        // عرض مؤشر التحميل
        if (_isLoading && isCurrentTrack) {
          return const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(),
          );
        }

        final isPlaying = _audioPlayer.playing && isCurrentTrack;

        return IconButton(
          icon: Icon(
            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
            size: 48,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.green,
          ),
          onPressed: () => _togglePlayPause(audio),
        );
      },
    );
  }
}
