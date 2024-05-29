import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

class RequestMathcher extends Matcher {
  RequestMathcher(this.url, {this.bodyFields});

  final String url;
  final Map<String, dynamic>? bodyFields;

  @override
  Description describe(final Description description) => description.add('Ok');

  @override
  bool matches(final item, final Map<dynamic, dynamic> matchState) {
    if (item is! http.Request) {
      return false;
    }

    return item.url.toString().endsWith(url) &&
        (bodyFields == null || mapEquals(item.bodyFields, bodyFields));
  }
}
