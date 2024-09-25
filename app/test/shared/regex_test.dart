import 'package:app/core/helpers/regex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('removeEmoji', () {
    expect(removeEmoji('Hello world 🌍.'), 'Hello world .');
    expect(removeEmoji('👋 Hello 🌍 World! 🎉'), ' Hello  World! ');
    expect(removeEmoji('No emojis here'), 'No emojis here');
  });
}
