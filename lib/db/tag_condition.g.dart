// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_condition.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TagConditionSchema = Schema(
  name: r'TagCondition',
  id: 6828889345970594228,
  properties: {
    r'caseSensitive': PropertySchema(
      id: 0,
      name: r'caseSensitive',
      type: IsarType.bool,
    ),
    r'invert': PropertySchema(
      id: 1,
      name: r'invert',
      type: IsarType.bool,
    ),
    r'matchType': PropertySchema(
      id: 2,
      name: r'matchType',
      type: IsarType.byte,
      enumMap: _TagConditionmatchTypeEnumValueMap,
    ),
    r'search': PropertySchema(
      id: 3,
      name: r'search',
      type: IsarType.string,
    ),
    r'target': PropertySchema(
      id: 4,
      name: r'target',
      type: IsarType.byte,
      enumMap: _TagConditiontargetEnumValueMap,
    )
  },
  estimateSize: _tagConditionEstimateSize,
  serialize: _tagConditionSerialize,
  deserialize: _tagConditionDeserialize,
  deserializeProp: _tagConditionDeserializeProp,
);

int _tagConditionEstimateSize(
  TagCondition object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.search.length * 3;
  return bytesCount;
}

void _tagConditionSerialize(
  TagCondition object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.caseSensitive);
  writer.writeBool(offsets[1], object.invert);
  writer.writeByte(offsets[2], object.matchType.index);
  writer.writeString(offsets[3], object.search);
  writer.writeByte(offsets[4], object.target.index);
}

TagCondition _tagConditionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TagCondition();
  object.caseSensitive = reader.readBool(offsets[0]);
  object.invert = reader.readBool(offsets[1]);
  object.matchType =
      _TagConditionmatchTypeValueEnumMap[reader.readByteOrNull(offsets[2])] ??
          ConditionMatchType.contains;
  object.search = reader.readString(offsets[3]);
  object.target =
      _TagConditiontargetValueEnumMap[reader.readByteOrNull(offsets[4])] ??
          TagTarget.name;
  return object;
}

P _tagConditionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (_TagConditionmatchTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ConditionMatchType.contains) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (_TagConditiontargetValueEnumMap[reader.readByteOrNull(offset)] ??
          TagTarget.name) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TagConditionmatchTypeEnumValueMap = {
  'contains': 0,
  'startsWith': 1,
  'endsWith': 2,
  'exact': 3,
  'wildcard': 4,
  'regexp': 5,
};
const _TagConditionmatchTypeValueEnumMap = {
  0: ConditionMatchType.contains,
  1: ConditionMatchType.startsWith,
  2: ConditionMatchType.endsWith,
  3: ConditionMatchType.exact,
  4: ConditionMatchType.wildcard,
  5: ConditionMatchType.regexp,
};
const _TagConditiontargetEnumValueMap = {
  'name': 0,
  'description': 1,
  'nameOrDescription': 2,
};
const _TagConditiontargetValueEnumMap = {
  0: TagTarget.name,
  1: TagTarget.description,
  2: TagTarget.nameOrDescription,
};

extension TagConditionQueryFilter
    on QueryBuilder<TagCondition, TagCondition, QFilterCondition> {
  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      caseSensitiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caseSensitive',
        value: value,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition> invertEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invert',
        value: value,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      matchTypeEqualTo(ConditionMatchType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchType',
        value: value,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      matchTypeGreaterThan(
    ConditionMatchType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matchType',
        value: value,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      matchTypeLessThan(
    ConditionMatchType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matchType',
        value: value,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      matchTypeBetween(
    ConditionMatchType lower,
    ConditionMatchType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matchType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition> searchEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'search',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      searchGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'search',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      searchLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'search',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition> searchBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'search',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      searchStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'search',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      searchEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'search',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      searchContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'search',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition> searchMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'search',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      searchIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'search',
        value: '',
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      searchIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'search',
        value: '',
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition> targetEqualTo(
      TagTarget value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'target',
        value: value,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      targetGreaterThan(
    TagTarget value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'target',
        value: value,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition>
      targetLessThan(
    TagTarget value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'target',
        value: value,
      ));
    });
  }

  QueryBuilder<TagCondition, TagCondition, QAfterFilterCondition> targetBetween(
    TagTarget lower,
    TagTarget upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'target',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TagConditionQueryObject
    on QueryBuilder<TagCondition, TagCondition, QFilterCondition> {}
