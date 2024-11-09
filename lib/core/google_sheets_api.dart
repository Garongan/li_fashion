import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GoogleSheetsApi {
  final _apiKey = dotenv.env['API_KEY'];
  final _spreadsheetId = dotenv.env['SPREADSHEET_ID'];

  Future<List<List<dynamic>>> getSpreadsheetData(String range) async {
    final url =
        'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId/values/$range?key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<List<dynamic>>.from(data['values']);
    } else {
      throw Exception('Failed to load spreadsheet data');
    }
  }
}