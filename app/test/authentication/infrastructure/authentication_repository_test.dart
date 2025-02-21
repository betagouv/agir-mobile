// ignore_for_file: avoid-duplicate-initializers

import 'dart:convert';

import 'package:app/core/authentication/domain/token.dart';
import 'package:app/core/authentication/domain/user_id.dart';
import 'package:app/core/authentication/infrastructure/authentication_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late AuthenticationStorage repository;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    when(() => mockSecureStorage.read(key: 'token')).thenAnswer((final answer) async => null);
    when(
      () => mockSecureStorage.write(key: any(named: 'key'), value: any(named: 'value')),
    ).thenAnswer((final answer) async => Future<void>.value());
    when(() => mockSecureStorage.delete(key: any(named: 'key'))).thenAnswer((final answer) async => Future<void>.value());
    repository = AuthenticationStorage(mockSecureStorage);
  });

  group('Authentication Repository', () {
    test('Saving a token', () async {
      // Given
      final value = 'header.${base64Encode(jsonEncode({'exp': 1727698718, 'utilisateurId': 'user123'}).codeUnits)}.signature';

      // When
      await repository.saveToken(value);

      // Then
      verify(() => mockSecureStorage.write(key: 'token', value: value)).called(1);
    });

    test('Deleting a token', () async {
      // When
      await repository.deleteAuthToken();

      // Then
      verify(() => mockSecureStorage.delete(key: 'token')).called(1);

      expect(() => repository.userId, throwsException);
      expect(() => repository.expirationDate, throwsException);
    });

    test('Getting token', () async {
      // Given
      final validToken =
          'header.${base64Encode(jsonEncode({'exp': 1727698718, 'utilisateurId': 'user123'}).codeUnits)}.signature';
      when(() => mockSecureStorage.read(key: 'token')).thenAnswer((final answer) async => validToken);
      await repository.init();

      // When
      final token = repository.token;

      // Then
      expect(token, equals(Token(validToken)));
    });

    test('Getting user ID', () async {
      // Given
      final validToken =
          'header.${base64Encode(jsonEncode({'exp': 1727698718, 'utilisateurId': 'user123'}).codeUnits)}.signature';
      when(() => mockSecureStorage.read(key: 'token')).thenAnswer((final answer) async => validToken);
      await repository.init();

      // When
      final userId = repository.userId;

      // Then
      expect(userId, equals(const UserId('user123')));
    });

    test('Getting expiration date', () async {
      // Given
      const expirationTime = 1727698718;
      final validToken =
          'header.${base64Encode(jsonEncode({'exp': expirationTime, 'utilisateurId': 'user123'}).codeUnits)}.signature';
      when(() => mockSecureStorage.read(key: 'token')).thenAnswer((final answer) async => validToken);
      await repository.init();

      // When
      final expirationDate = repository.expirationDate;

      // Then
      expect(expirationDate.value, DateTime.fromMillisecondsSinceEpoch(expirationTime * 1000, isUtc: true));
    });

    test('Handling missing token', () {
      // When & Then
      expect(() => repository.userId, throwsException);
      expect(() => repository.expirationDate, throwsException);
    });

    test('Caching behavior for user ID', () async {
      // Given
      final validToken =
          'header.${base64Encode(jsonEncode({'exp': 1727698718, 'utilisateurId': 'user123'}).codeUnits)}.signature';
      when(() => mockSecureStorage.read(key: 'token')).thenAnswer((final answer) async => validToken);
      await repository.init();

      // When
      final userId1 = repository.userId;
      final userId2 = repository.userId;

      // Then
      expect(userId1, equals(const UserId('user123')));
      expect(userId2, equals(const UserId('user123')));
      verify(() => mockSecureStorage.read(key: 'token')).called(1);
    });

    test('Caching behavior for expiration date', () async {
      // Given
      final validToken =
          'header.${base64Encode(jsonEncode({'exp': 1727698718, 'utilisateurId': 'user123'}).codeUnits)}.signature';
      when(() => mockSecureStorage.read(key: 'token')).thenAnswer((final answer) async => validToken);
      await repository.init();

      // When
      final expirationDate1 = repository.expirationDate;
      final expirationDate2 = repository.expirationDate;

      // Then
      expect(expirationDate1, equals(expirationDate2));
      verify(() => mockSecureStorage.read(key: 'token')).called(1);
    });
  });
}
