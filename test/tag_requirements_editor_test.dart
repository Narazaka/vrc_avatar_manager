import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vrc_avatar_manager/db/stat_requirement.dart';
import 'package:vrc_avatar_manager/db/tag.dart';
import 'package:vrc_avatar_manager/db/tag_type.dart';
import 'package:vrc_avatar_manager/tag_requirements_editor.dart';

void main() {
  testWidgets('renders a stat requirement with an unknown key', (tester) async {
    final tag = Tag()
      ..empty()
      ..type = TagType.conditions
      ..statRequirements = [StatRequirement()..stat = 'Triangles'];
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: TagRequirementsEditor(tag: tag, onChanged: () {}),
        ),
      ),
    ));
    expect(tester.takeException(), isNull);
    expect(find.byType(DropdownButton<String>), findsOneWidget);
  });
}
