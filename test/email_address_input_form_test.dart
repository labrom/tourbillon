import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourbillon/email_address_input_form.dart';
import 'package:tourbillon/libloc.dart';

void main() {
  group('with button', () {
    testWidgets('valid email', (tester) async {
      String? emailAddress;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            LibLocalizations.delegate,
          ],
          home: Material(
            child: EmailAddressInputForm((email) => emailAddress = email),
          ),
        ),
      );
      await tester.enterText(find.byType(TextFormField), 'user@my.org');
      await tester.pump();
      await tester.tap(find.byType(TextButton));
      expect(emailAddress, equals('user@my.org'));
      emailAddress = null;

      await tester.enterText(find.byType(TextFormField), 'user.1@my.org');
      await tester.pump();
      await tester.tap(find.byType(TextButton));
      expect(emailAddress, equals('user.1@my.org'));
      emailAddress = null;

      await tester.enterText(find.byType(TextFormField), '1+2@my.org');
      await tester.pump();
      await tester.tap(find.byType(TextButton));
      expect(emailAddress, equals('1+2@my.org'));
    });

    testWidgets('invalid email', (tester) async {
      String? emailAddress;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            LibLocalizations.delegate,
          ],
          home: Material(
            child: EmailAddressInputForm((email) => emailAddress = email),
          ),
        ),
      );
      await tester.enterText(find.byType(TextFormField), '@my.org');
      await tester.pump();
      await tester.tap(find.byType(TextButton));
      expect(emailAddress, isNull);

      await tester.enterText(find.byType(TextFormField), 'user@');
      await tester.pump();
      await tester.tap(find.byType(TextButton));
      expect(emailAddress, isNull);

      await tester.enterText(find.byType(TextFormField), 'user@my');
      await tester.pump();
      await tester.tap(find.byType(TextButton));
      expect(emailAddress, isNull);

      await tester.enterText(find.byType(TextFormField), 'user@.org');
      await tester.pump();
      await tester.tap(find.byType(TextButton));
      expect(emailAddress, isNull);
    });
  });

  group('without button', () {
    testWidgets('valid email', (tester) async {
      String? expectedInput;
      String? textInput;
      bool validEmail = false;
      var controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            LibLocalizations.delegate,
          ],
          home: Material(
            child: EmailAddressInputForm.withoutAddButton(
              onEmailAddressValidityChanged: (input, valid) {
                textInput = input;
                validEmail = valid;
              },
              controller: controller,
            ),
          ),
        ),
      );
      expectedInput = 'user@my.org';
      await tester.enterText(find.byType(TextFormField), expectedInput);
      expect(textInput, equals(expectedInput));
      expect(validEmail, isTrue);
      textInput = null;
      validEmail = false;
      controller.clear();

      expectedInput = 'user.1@my.org';
      await tester.enterText(find.byType(TextFormField), expectedInput);
      expect(textInput, equals(expectedInput));
      expect(validEmail, isTrue);
      textInput = null;
      validEmail = false;
      controller.clear();

      expectedInput = '1+2@my.org';
      await tester.enterText(find.byType(TextFormField), expectedInput);
      expect(textInput, equals(expectedInput));
      expect(validEmail, isTrue);
      textInput = null;
      validEmail = false;
      controller.clear();
    });

    testWidgets('invalid email', (tester) async {
      String? expectedInput;
      String? textInput;
      bool validEmail = false;
      var controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            LibLocalizations.delegate,
          ],
          home: Material(
            child: EmailAddressInputForm.withoutAddButton(
              onEmailAddressValidityChanged: (input, valid) {
                textInput = input;
                validEmail = valid;
              },
              controller: controller,
            ),
          ),
        ),
      );

      expectedInput = '@my.org';
      await tester.enterText(find.byType(TextFormField), expectedInput);
      expect(textInput, isNull);
      expect(validEmail, isFalse);
      controller.clear();

      expectedInput = 'user@';
      await tester.enterText(find.byType(TextFormField), expectedInput);
      expect(textInput, isNull);
      expect(validEmail, isFalse);
      controller.clear();

      expectedInput = 'user@my';
      await tester.enterText(find.byType(TextFormField), expectedInput);
      expect(textInput, isNull);
      expect(validEmail, isFalse);
      controller.clear();

      expectedInput = 'user@.org';
      await tester.enterText(find.byType(TextFormField), expectedInput);
      expect(textInput, isNull);
      expect(validEmail, isFalse);
      controller.clear();
    });
  });
}
