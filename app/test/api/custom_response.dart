import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomResponse extends http.StreamedResponse {
  CustomResponse(final String value, final int statusCode)
      : super(Stream<List<int>>.value(utf8.encode(value)), statusCode);
}
