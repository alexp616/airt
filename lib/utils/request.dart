import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class RequestClient {
  final String host;

  RequestClient(this.host);

  Future<List<Uint8List>> generateImages(String prompt) async {
    final response = await http.post(
      Uri.parse('${host}diffusion'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true'
      }, body: jsonEncode({ 
        'prompt': prompt 
      })
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return [for (String base64 in json['output']) base64Decode(base64)];
    } else {
      throw Exception('Request failed: ${response.statusCode}');
    }
  }

  Future<Uint8List> mergeImages(Uint8List content, Uint8List style) async {
    String base64Content = base64Encode(content);
    String base64Style = base64Encode(style);
    
    final response = await http.post(
      Uri.parse('${host}merge'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true'
      }, body: jsonEncode({
        'input': base64Content,
        'style': base64Style
      })
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return base64Decode(json['output']);
    } else {
      throw Exception('Request failed: ${response.statusCode}');
    }
  }
}