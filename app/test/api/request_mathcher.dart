// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

class RequestMathcher extends Matcher {
  const RequestMathcher(this.url, {this.body});

  final String url;
  final String? body;

  @override
  Description describe(final Description description) => description.add('Ok');

  @override
  bool matches(final item, final Map<dynamic, dynamic> matchState) =>
      item is http.Request
          ? Uri.decodeComponent(item.url.toString()).endsWith(url) &&
              (body == null || body == item.body)
          : false;
}
