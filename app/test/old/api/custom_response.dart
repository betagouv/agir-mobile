import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class CustomResponse extends http.StreamedResponse {
  CustomResponse(final String value, {final int statusCode = HttpStatus.ok})
      : super(
          Stream<List<int>>.value(utf8.encode(value)),
          statusCode,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        );
}
