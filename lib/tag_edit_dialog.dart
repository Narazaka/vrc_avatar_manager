import 'package:flutter/material.dart';
import 'package:vrc_avatar_manager/db/tag.dart';
import 'package:vrc_avatar_manager/db/tag_target.dart';
import 'package:vrc_avatar_manager/db/tag_type.dart';
import 'package:vrc_avatar_manager/db/tags_db.dart';

class TagEditDialog extends StatefulWidget {
  const TagEditDialog({super.key, required this.tag, required this.isNew});
  final Tag tag;
  final bool isNew;

  @override
  State<TagEditDialog> createState() => _TagEditDialogState();

  static Future<String?> show(
    BuildContext context,
    Tag tag,
    bool isNew,
  ) async {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return TagEditDialog(tag: tag, isNew: isNew);
      },
    );
  }
}

class _TagEditDialogState extends State<TagEditDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  TagType _type = TagType.items;
  TagTarget _target = TagTarget.name;
  final _searchController = TextEditingController();
  bool _invert = false;
  bool _caseSensitive = false;

  @override
  void dispose() {
    _nameController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.tag.name;
    _type = widget.tag.type;
    _target = widget.tag.target;
    _searchController.text = widget.tag.search;
    _invert = widget.tag.invert;
    _caseSensitive = widget.tag.caseSensitive;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '名前',
              ),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            DropdownButton<TagType>(
              value: _type,
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
              items: TagType.values
                  .map((e) =>
                      DropdownMenuItem(value: e, child: Text(e.toString())))
                  .toList(),
            ),
            if (_type != TagType.items)
              DropdownButton<TagTarget>(
                value: _target,
                onChanged: (value) {
                  setState(() {
                    _target = value!;
                  });
                },
                items: TagTarget.values
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e.toString())))
                    .toList(),
              ),
            if (_type != TagType.items)
              TextFormField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: '検索文字列',
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
            if (_type != TagType.items)
              CheckboxListTile(
                value: _invert,
                onChanged: (value) {
                  setState(() {
                    _invert = value!;
                  });
                },
                title: const Text("NOT条件"),
              ),
            if (_type != TagType.items)
              CheckboxListTile(
                value: _caseSensitive,
                onChanged: (value) {
                  setState(() {
                    _caseSensitive = value!;
                  });
                },
                title: const Text("大文字小文字を区別する"),
              ),
          ])),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) {
              return;
            }

            widget.tag
              ..name = _nameController.text
              ..type = _type
              ..target = _target
              ..search = _searchController.text
              ..invert = _invert
              ..caseSensitive = _caseSensitive;
            await (await TagsDb.instance).put(widget.tag);

            Navigator.of(context).pop();
          },
          child: const Text('OK'),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, foregroundColor: Colors.white),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        if (!widget.isNew)
          ElevatedButton(
            onPressed: () async {
              await (await TagsDb.instance).delete(widget.tag);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
          ),
      ],
    );
  }
}
