import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class WhisperService {
  final String _apiUrl = 'https://api.openai.com/v1/audio/transcriptions';
  final String _apiKey = 'sk-proj-4l1duJhdr4b8wiIxYJ6oT3BlbkFJXB0UWdTP34QTtwI6Jm8P';

  Future<String> transcribeAudio(File audioFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_apiUrl))
        ..headers['Authorization'] = 'Bearer $_apiKey'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..files.add(await http.MultipartFile.fromPath('file', audioFile.path))
        ..fields['model'] = 'whisper-1';

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var data = json.decode(responseData);
        print('Transcription: $data');
        return data['text'];
      } else {
        print('Failed to transcribe audio: ${response.statusCode}');
        return Future.error('Failed to transcribe audio');
      }
    } catch (e) {
      print('Error: $e');
      return Future.error('Failed to transcribe audio');
    }
  }
}
