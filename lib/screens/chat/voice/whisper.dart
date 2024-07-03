import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'audio_player.dart';
import 'audio_recorder.dart';
import 'whisper_service.dart';

class Voice extends StatefulWidget {

  const Voice({
    super.key,
  });

  @override
  State<Voice> createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {

  bool showPlayer = false;
  String? audioPath;
  String? transcription;
  final WhisperService _whisperService = WhisperService();

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  Future<void> handleTranscription(String path) async {
    try {
      File audioFile = File(path);
      String transcribedText = await _whisperService.transcribeAudio(audioFile);
      setState(() {
        transcription = transcribedText;
      });
    } catch (e) {
      if (kDebugMode) print('Transcription error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              if (showPlayer)
              Expanded(child:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: AudioPlayer(
                    source: audioPath!,
                    onDelete: () {
                      setState(() => showPlayer = false);
                    },
                  ),
                ),
                ),
                const SizedBox(height: 16),
              if (!showPlayer)
              Expanded(child:
                Recorder(
                  onStop: (path) {
                    if (kDebugMode) print('Recorded file path: $path');
                    setState(() {
                      audioPath = path;
                      showPlayer = true;
                    });
                    handleTranscription(path);
                  },
                ),
                ),
              if (transcription != null)
              Expanded(child:
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Transcription: $transcription',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
