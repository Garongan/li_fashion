import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:li_fashion/features/fashion/fashion.dart';

class GoogleSheetsApi {
  final _apiKey = dotenv.env['API_KEY'];
  final _spreadsheetId = dotenv.env['SPREADSHEET_ID'];

  Future<List<List<dynamic>>> getSpreadsheetData(String range) async {
    final url =
        'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId/values/$range?key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<List<dynamic>>.from(data['values']).skip(1).toList();
    } else {
      throw Exception('Failed to load spreadsheet data');
    }
  }

  Future<List<Fashion>> getFashionData(String category) async {
    final url =
        'https://sheets.googleapis.com/v4/spreadsheets/$_spreadsheetId/values/Sheet1?key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> rows = data['values'];

      rows.removeAt(0);

      List<Fashion> fashions =
          rows.map((row) => Fashion.fromSheet(row)).toList();
      if (category == '') {
        return fashions;
      }
      return fashions
          .where((value) => value.category.contains(category))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
