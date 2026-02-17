// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_condition_group.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TagConditionGroupSchema = Schema(
  name: r'TagConditionGroup',
  id: -6047755967976230204,
  properties: {
    r'conditions': PropertySchema(
      id: 0,
      name: r'conditions',
      type: IsarType.objectList,
      target: r'TagCondition',
    )
  },
  estimateSize: _tagConditionGroupEstimateSize,
  serialize: _tagConditionGroupSerialize,
  deserialize: _tagConditionGroupDeserialize,
  deserializeProp: _tagConditionGroupDeserializeProp,
);

int _tagConditionGroupEstimateSize(
  TagConditionGroup object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.conditions.length * 3;
  {
    final offsets = allOffsets[TagCondition]!;
    for (var i = 0; i < object.conditions.length; i++) {
      final value = object.conditions[i];
      bytesCount += TagConditionSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _tagConditionGroupSerialize(
  TagConditionGroup object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<TagCondition>(
    offsets[0],
    allOffsets,
    TagConditionSchema.serialize,
    object.conditions,
  );
}

TagConditionGroup _tagConditionGroupDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TagConditionGroup();
  object.conditions = reader.readObjectList<TagCondition>(
        offsets[0],
        TagConditionSchema.deserialize,
        allOffsets,
        TagCondition(),
      ) ??
      [];
  return object;
}

P _tagConditionGroupDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<TagCondition>(
            offset,
            TagConditionSchema.deserialize,
            allOffsets,
            TagCondition(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TagConditionGroupQueryFilter
    on QueryBuilder<TagConditionGroup, TagConditionGroup, QFilterCondition> {
  QueryBuilder<TagConditionGroup, TagConditionGroup, QAfterFilterCondition>
      conditionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TagConditionGroup, TagConditionGroup, QAfterFilterCondition>
      conditionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TagConditionGroup, TagConditionGroup, QAfterFilterCondition>
      conditionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TagConditionGroup, TagConditionGroup, QAfterFilterCondition>
      conditionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TagConditionGroup, TagConditionGroup, QAfterFilterCondition>
      conditionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TagConditionGroup, TagConditionGroup, QAfterFilterCondition>
      conditionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension TagConditionGroupQueryObject
    on QueryBuilder<TagConditionGroup, TagConditionGroup, QFilterCondition> {
  QueryBuilder<TagConditionGroup, TagConditionGroup, QAfterFilterCondition>
      conditionsElement(FilterQuery<TagCondition> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'conditions');
    });
  }
}
