import 'package:flutter/material.dart';

String capitalize(final String text) =>
    text[0].toUpperCase() + text.characters.getRange(1).string;
