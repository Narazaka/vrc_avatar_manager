import 'package:flutter/material.dart';

const hasImposterBadge = Badge(
  label: Text("i"),
  textStyle: TextStyle(fontSize: 9),
  backgroundColor: Colors.cyan,
  largeSize: 9,
);

const noImposterBadge = Badge(
  label: Text("i"),
  textStyle: TextStyle(fontSize: 9),
  backgroundColor: Colors.red,
  largeSize: 9,
);

var hasImposterInactiveBadge = Badge(
  label: const Text("i"),
  textStyle: const TextStyle(fontSize: 9),
  backgroundColor: Colors.cyan[300],
  largeSize: 9,
);

var noImposterInactiveBadge = Badge(
  label: const Text("i"),
  textStyle: const TextStyle(fontSize: 9),
  backgroundColor: Colors.red[200],
  largeSize: 9,
);

enum FilterByImposter {
  none,
  haveImposter,
  notHaveImposter,
}
