// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTagCollection on Isar {
  IsarCollection<Tag> get tags => this.collection();
}

const TagSchema = CollectionSchema(
  name: r'Tag',
  id: 4007045862261149568,
  properties: {
    r'caseSensitive': PropertySchema(
      id: 0,
      name: r'caseSensitive',
      type: IsarType.bool,
    ),
    r'color': PropertySchema(
      id: 1,
      name: r'color',
      type: IsarType.long,
    ),
    r'conditionGroups': PropertySchema(
      id: 2,
      name: r'conditionGroups',
      type: IsarType.objectList,
      target: r'TagConditionGroup',
    ),
    r'groupCombinator': PropertySchema(
      id: 3,
      name: r'groupCombinator',
      type: IsarType.byte,
      enumMap: _TaggroupCombinatorEnumValueMap,
    ),
    r'groupId': PropertySchema(
      id: 4,
      name: r'groupId',
      type: IsarType.long,
    ),
    r'ignoreAndroidPerformanceRatings': PropertySchema(
      id: 5,
      name: r'ignoreAndroidPerformanceRatings',
      type: IsarType.byteList,
      enumMap: _TagignoreAndroidPerformanceRatingsEnumValueMap,
    ),
    r'ignorePcPerformanceRatings': PropertySchema(
      id: 6,
      name: r'ignorePcPerformanceRatings',
      type: IsarType.byteList,
      enumMap: _TagignorePcPerformanceRatingsEnumValueMap,
    ),
    r'inactiveColor': PropertySchema(
      id: 7,
      name: r'inactiveColor',
      type: IsarType.long,
    ),
    r'invert': PropertySchema(
      id: 8,
      name: r'invert',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 9,
      name: r'name',
      type: IsarType.string,
    ),
    r'order': PropertySchema(
      id: 10,
      name: r'order',
      type: IsarType.long,
    ),
    r'requireAndroid': PropertySchema(
      id: 11,
      name: r'requireAndroid',
      type: IsarType.bool,
    ),
    r'requirePc': PropertySchema(
      id: 12,
      name: r'requirePc',
      type: IsarType.bool,
    ),
    r'search': PropertySchema(
      id: 13,
      name: r'search',
      type: IsarType.string,
    ),
    r'target': PropertySchema(
      id: 14,
      name: r'target',
      type: IsarType.byte,
      enumMap: _TagtargetEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 15,
      name: r'type',
      type: IsarType.byte,
      enumMap: _TagtypeEnumValueMap,
    )
  },
  estimateSize: _tagEstimateSize,
  serialize: _tagSerialize,
  deserialize: _tagDeserialize,
  deserializeProp: _tagDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'tagAvatars': LinkSchema(
      id: 5139458228394406842,
      name: r'tagAvatars',
      target: r'TagAvatar',
      single: false,
      linkName: r'tags',
    )
  },
  embeddedSchemas: {
    r'TagConditionGroup': TagConditionGroupSchema,
    r'TagCondition': TagConditionSchema
  },
  getId: _tagGetId,
  getLinks: _tagGetLinks,
  attach: _tagAttach,
  version: '3.1.0+1',
);

int _tagEstimateSize(
  Tag object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.conditionGroups.length * 3;
  {
    final offsets = allOffsets[TagConditionGroup]!;
    for (var i = 0; i < object.conditionGroups.length; i++) {
      final value = object.conditionGroups[i];
      bytesCount +=
          TagConditionGroupSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.ignoreAndroidPerformanceRatings.length;
  bytesCount += 3 + object.ignorePcPerformanceRatings.length;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.search.length * 3;
  return bytesCount;
}

void _tagSerialize(
  Tag object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.caseSensitive);
  writer.writeLong(offsets[1], object.color);
  writer.writeObjectList<TagConditionGroup>(
    offsets[2],
    allOffsets,
    TagConditionGroupSchema.serialize,
    object.conditionGroups,
  );
  writer.writeByte(offsets[3], object.groupCombinator.index);
  writer.writeLong(offsets[4], object.groupId);
  writer.writeByteList(offsets[5],
      object.ignoreAndroidPerformanceRatings.map((e) => e.index).toList());
  writer.writeByteList(offsets[6],
      object.ignorePcPerformanceRatings.map((e) => e.index).toList());
  writer.writeLong(offsets[7], object.inactiveColor);
  writer.writeBool(offsets[8], object.invert);
  writer.writeString(offsets[9], object.name);
  writer.writeLong(offsets[10], object.order);
  writer.writeBool(offsets[11], object.requireAndroid);
  writer.writeBool(offsets[12], object.requirePc);
  writer.writeString(offsets[13], object.search);
  writer.writeByte(offsets[14], object.target.index);
  writer.writeByte(offsets[15], object.type.index);
}

Tag _tagDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Tag();
  object.caseSensitive = reader.readBool(offsets[0]);
  object.color = reader.readLong(offsets[1]);
  object.conditionGroups = reader.readObjectList<TagConditionGroup>(
        offsets[2],
        TagConditionGroupSchema.deserialize,
        allOffsets,
        TagConditionGroup(),
      ) ??
      [];
  object.groupCombinator =
      _TaggroupCombinatorValueEnumMap[reader.readByteOrNull(offsets[3])] ??
          ConditionCombinator.and;
  object.groupId = reader.readLong(offsets[4]);
  object.id = id;
  object.ignoreAndroidPerformanceRatings = reader
          .readByteList(offsets[5])
          ?.map((e) =>
              _TagignoreAndroidPerformanceRatingsValueEnumMap[e] ??
              PerformanceRatings.none)
          .toList() ??
      [];
  object.ignorePcPerformanceRatings = reader
          .readByteList(offsets[6])
          ?.map((e) =>
              _TagignorePcPerformanceRatingsValueEnumMap[e] ??
              PerformanceRatings.none)
          .toList() ??
      [];
  object.inactiveColor = reader.readLong(offsets[7]);
  object.invert = reader.readBool(offsets[8]);
  object.name = reader.readString(offsets[9]);
  object.order = reader.readLong(offsets[10]);
  object.requireAndroid = reader.readBool(offsets[11]);
  object.requirePc = reader.readBool(offsets[12]);
  object.search = reader.readString(offsets[13]);
  object.target = _TagtargetValueEnumMap[reader.readByteOrNull(offsets[14])] ??
      TagTarget.name;
  object.type =
      _TagtypeValueEnumMap[reader.readByteOrNull(offsets[15])] ?? TagType.items;
  return object;
}

P _tagDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readObjectList<TagConditionGroup>(
            offset,
            TagConditionGroupSchema.deserialize,
            allOffsets,
            TagConditionGroup(),
          ) ??
          []) as P;
    case 3:
      return (_TaggroupCombinatorValueEnumMap[reader.readByteOrNull(offset)] ??
          ConditionCombinator.and) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader
              .readByteList(offset)
              ?.map((e) =>
                  _TagignoreAndroidPerformanceRatingsValueEnumMap[e] ??
                  PerformanceRatings.none)
              .toList() ??
          []) as P;
    case 6:
      return (reader
              .readByteList(offset)
              ?.map((e) =>
                  _TagignorePcPerformanceRatingsValueEnumMap[e] ??
                  PerformanceRatings.none)
              .toList() ??
          []) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (_TagtargetValueEnumMap[reader.readByteOrNull(offset)] ??
          TagTarget.name) as P;
    case 15:
      return (_TagtypeValueEnumMap[reader.readByteOrNull(offset)] ??
          TagType.items) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TaggroupCombinatorEnumValueMap = {
  'and': 0,
  'or': 1,
};
const _TaggroupCombinatorValueEnumMap = {
  0: ConditionCombinator.and,
  1: ConditionCombinator.or,
};
const _TagignoreAndroidPerformanceRatingsEnumValueMap = {
  'none': 0,
  'excellent': 1,
  'good': 2,
  'medium': 3,
  'poor': 4,
  'veryPoor': 5,
};
const _TagignoreAndroidPerformanceRatingsValueEnumMap = {
  0: PerformanceRatings.none,
  1: PerformanceRatings.excellent,
  2: PerformanceRatings.good,
  3: PerformanceRatings.medium,
  4: PerformanceRatings.poor,
  5: PerformanceRatings.veryPoor,
};
const _TagignorePcPerformanceRatingsEnumValueMap = {
  'none': 0,
  'excellent': 1,
  'good': 2,
  'medium': 3,
  'poor': 4,
  'veryPoor': 5,
};
const _TagignorePcPerformanceRatingsValueEnumMap = {
  0: PerformanceRatings.none,
  1: PerformanceRatings.excellent,
  2: PerformanceRatings.good,
  3: PerformanceRatings.medium,
  4: PerformanceRatings.poor,
  5: PerformanceRatings.veryPoor,
};
const _TagtargetEnumValueMap = {
  'name': 0,
  'description': 1,
  'nameOrDescription': 2,
};
const _TagtargetValueEnumMap = {
  0: TagTarget.name,
  1: TagTarget.description,
  2: TagTarget.nameOrDescription,
};
const _TagtypeEnumValueMap = {
  'items': 0,
  'simple': 1,
  'regexp': 2,
  'conditions': 3,
};
const _TagtypeValueEnumMap = {
  0: TagType.items,
  1: TagType.simple,
  2: TagType.regexp,
  3: TagType.conditions,
};

Id _tagGetId(Tag object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tagGetLinks(Tag object) {
  return [object.tagAvatars];
}

void _tagAttach(IsarCollection<dynamic> col, Id id, Tag object) {
  object.id = id;
  object.tagAvatars
      .attach(col, col.isar.collection<TagAvatar>(), r'tagAvatars', id);
}

extension TagQueryWhereSort on QueryBuilder<Tag, Tag, QWhere> {
  QueryBuilder<Tag, Tag, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TagQueryWhere on QueryBuilder<Tag, Tag, QWhereClause> {
  QueryBuilder<Tag, Tag, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TagQueryFilter on QueryBuilder<Tag, Tag, QFilterCondition> {
  QueryBuilder<Tag, Tag, QAfterFilterCondition> caseSensitiveEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'caseSensitive',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> colorEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> colorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> colorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> colorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> conditionGroupsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditionGroups',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> conditionGroupsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditionGroups',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> conditionGroupsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditionGroups',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> conditionGroupsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditionGroups',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      conditionGroupsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditionGroups',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> conditionGroupsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'conditionGroups',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> groupCombinatorEqualTo(
      ConditionCombinator value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupCombinator',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> groupCombinatorGreaterThan(
    ConditionCombinator value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupCombinator',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> groupCombinatorLessThan(
    ConditionCombinator value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupCombinator',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> groupCombinatorBetween(
    ConditionCombinator lower,
    ConditionCombinator upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupCombinator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> groupIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupId',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> groupIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupId',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> groupIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupId',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> groupIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignoreAndroidPerformanceRatingsElementEqualTo(PerformanceRatings value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ignoreAndroidPerformanceRatings',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignoreAndroidPerformanceRatingsElementGreaterThan(
    PerformanceRatings value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ignoreAndroidPerformanceRatings',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignoreAndroidPerformanceRatingsElementLessThan(
    PerformanceRatings value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ignoreAndroidPerformanceRatings',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignoreAndroidPerformanceRatingsElementBetween(
    PerformanceRatings lower,
    PerformanceRatings upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ignoreAndroidPerformanceRatings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignoreAndroidPerformanceRatingsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroidPerformanceRatings',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignoreAndroidPerformanceRatingsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroidPerformanceRatings',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignoreAndroidPerformanceRatingsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroidPerformanceRatings',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignoreAndroidPerformanceRatingsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroidPerformanceRatings',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignoreAndroidPerformanceRatingsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroidPerformanceRatings',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignoreAndroidPerformanceRatingsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroidPerformanceRatings',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignorePcPerformanceRatingsElementEqualTo(PerformanceRatings value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ignorePcPerformanceRatings',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignorePcPerformanceRatingsElementGreaterThan(
    PerformanceRatings value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ignorePcPerformanceRatings',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignorePcPerformanceRatingsElementLessThan(
    PerformanceRatings value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ignorePcPerformanceRatings',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignorePcPerformanceRatingsElementBetween(
    PerformanceRatings lower,
    PerformanceRatings upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ignorePcPerformanceRatings',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignorePcPerformanceRatingsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePcPerformanceRatings',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignorePcPerformanceRatingsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePcPerformanceRatings',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignorePcPerformanceRatingsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePcPerformanceRatings',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignorePcPerformanceRatingsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePcPerformanceRatings',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignorePcPerformanceRatingsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePcPerformanceRatings',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition>
      ignorePcPerformanceRatingsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePcPerformanceRatings',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> inactiveColorEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inactiveColor',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> inactiveColorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inactiveColor',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> inactiveColorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inactiveColor',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> inactiveColorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inactiveColor',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> invertEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invert',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> orderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> orderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> orderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> orderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> requireAndroidEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requireAndroid',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> requirePcEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requirePc',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> searchEqualTo(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> searchGreaterThan(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> searchLessThan(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> searchBetween(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> searchStartsWith(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> searchEndsWith(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> searchContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'search',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> searchMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'search',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> searchIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'search',
        value: '',
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> searchIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'search',
        value: '',
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> targetEqualTo(TagTarget value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'target',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> targetGreaterThan(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> targetLessThan(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> targetBetween(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> typeEqualTo(TagType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> typeGreaterThan(
    TagType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> typeLessThan(
    TagType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> typeBetween(
    TagType lower,
    TagType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TagQueryObject on QueryBuilder<Tag, Tag, QFilterCondition> {
  QueryBuilder<Tag, Tag, QAfterFilterCondition> conditionGroupsElement(
      FilterQuery<TagConditionGroup> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'conditionGroups');
    });
  }
}

extension TagQueryLinks on QueryBuilder<Tag, Tag, QFilterCondition> {
  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagAvatars(
      FilterQuery<TagAvatar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'tagAvatars');
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagAvatarsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tagAvatars', length, true, length, true);
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagAvatarsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tagAvatars', 0, true, 0, true);
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagAvatarsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tagAvatars', 0, false, 999999, true);
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagAvatarsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tagAvatars', 0, true, length, include);
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagAvatarsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tagAvatars', length, include, 999999, true);
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagAvatarsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'tagAvatars', lower, includeLower, upper, includeUpper);
    });
  }
}

extension TagQuerySortBy on QueryBuilder<Tag, Tag, QSortBy> {
  QueryBuilder<Tag, Tag, QAfterSortBy> sortByCaseSensitive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caseSensitive', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByCaseSensitiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caseSensitive', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByGroupCombinator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupCombinator', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByGroupCombinatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupCombinator', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByInactiveColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inactiveColor', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByInactiveColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inactiveColor', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByInvert() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invert', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByInvertDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invert', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByRequireAndroid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAndroid', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByRequireAndroidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAndroid', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByRequirePc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requirePc', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByRequirePcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requirePc', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortBySearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'search', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortBySearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'search', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension TagQuerySortThenBy on QueryBuilder<Tag, Tag, QSortThenBy> {
  QueryBuilder<Tag, Tag, QAfterSortBy> thenByCaseSensitive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caseSensitive', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByCaseSensitiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'caseSensitive', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByGroupCombinator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupCombinator', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByGroupCombinatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupCombinator', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByInactiveColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inactiveColor', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByInactiveColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inactiveColor', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByInvert() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invert', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByInvertDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invert', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByRequireAndroid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAndroid', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByRequireAndroidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requireAndroid', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByRequirePc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requirePc', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByRequirePcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requirePc', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenBySearch() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'search', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenBySearchDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'search', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'target', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension TagQueryWhereDistinct on QueryBuilder<Tag, Tag, QDistinct> {
  QueryBuilder<Tag, Tag, QDistinct> distinctByCaseSensitive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'caseSensitive');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByGroupCombinator() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupCombinator');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupId');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct>
      distinctByIgnoreAndroidPerformanceRatings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ignoreAndroidPerformanceRatings');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByIgnorePcPerformanceRatings() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ignorePcPerformanceRatings');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByInactiveColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inactiveColor');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByInvert() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invert');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByRequireAndroid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requireAndroid');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByRequirePc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requirePc');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctBySearch(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'search', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'target');
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }
}

extension TagQueryProperty on QueryBuilder<Tag, Tag, QQueryProperty> {
  QueryBuilder<Tag, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Tag, bool, QQueryOperations> caseSensitiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'caseSensitive');
    });
  }

  QueryBuilder<Tag, int, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<Tag, List<TagConditionGroup>, QQueryOperations>
      conditionGroupsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'conditionGroups');
    });
  }

  QueryBuilder<Tag, ConditionCombinator, QQueryOperations>
      groupCombinatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupCombinator');
    });
  }

  QueryBuilder<Tag, int, QQueryOperations> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupId');
    });
  }

  QueryBuilder<Tag, List<PerformanceRatings>, QQueryOperations>
      ignoreAndroidPerformanceRatingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ignoreAndroidPerformanceRatings');
    });
  }

  QueryBuilder<Tag, List<PerformanceRatings>, QQueryOperations>
      ignorePcPerformanceRatingsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ignorePcPerformanceRatings');
    });
  }

  QueryBuilder<Tag, int, QQueryOperations> inactiveColorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inactiveColor');
    });
  }

  QueryBuilder<Tag, bool, QQueryOperations> invertProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invert');
    });
  }

  QueryBuilder<Tag, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Tag, int, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<Tag, bool, QQueryOperations> requireAndroidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requireAndroid');
    });
  }

  QueryBuilder<Tag, bool, QQueryOperations> requirePcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requirePc');
    });
  }

  QueryBuilder<Tag, String, QQueryOperations> searchProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'search');
    });
  }

  QueryBuilder<Tag, TagTarget, QQueryOperations> targetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'target');
    });
  }

  QueryBuilder<Tag, TagType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
