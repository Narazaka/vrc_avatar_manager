// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_requirement.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const StatRequirementSchema = Schema(
  name: r'StatRequirement',
  id: 7685284167889552481,
  properties: {
    r'ignoreAndroid': PropertySchema(
      id: 0,
      name: r'ignoreAndroid',
      type: IsarType.byteList,
      enumMap: _StatRequirementignoreAndroidEnumValueMap,
    ),
    r'ignorePc': PropertySchema(
      id: 1,
      name: r'ignorePc',
      type: IsarType.byteList,
      enumMap: _StatRequirementignorePcEnumValueMap,
    ),
    r'maxAndroid': PropertySchema(
      id: 2,
      name: r'maxAndroid',
      type: IsarType.double,
    ),
    r'maxPc': PropertySchema(
      id: 3,
      name: r'maxPc',
      type: IsarType.double,
    ),
    r'minAndroid': PropertySchema(
      id: 4,
      name: r'minAndroid',
      type: IsarType.double,
    ),
    r'minPc': PropertySchema(
      id: 5,
      name: r'minPc',
      type: IsarType.double,
    ),
    r'stat': PropertySchema(
      id: 6,
      name: r'stat',
      type: IsarType.string,
    )
  },
  estimateSize: _statRequirementEstimateSize,
  serialize: _statRequirementSerialize,
  deserialize: _statRequirementDeserialize,
  deserializeProp: _statRequirementDeserializeProp,
);

int _statRequirementEstimateSize(
  StatRequirement object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.ignoreAndroid.length;
  bytesCount += 3 + object.ignorePc.length;
  bytesCount += 3 + object.stat.length * 3;
  return bytesCount;
}

void _statRequirementSerialize(
  StatRequirement object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByteList(
      offsets[0], object.ignoreAndroid.map((e) => e.index).toList());
  writer.writeByteList(
      offsets[1], object.ignorePc.map((e) => e.index).toList());
  writer.writeDouble(offsets[2], object.maxAndroid);
  writer.writeDouble(offsets[3], object.maxPc);
  writer.writeDouble(offsets[4], object.minAndroid);
  writer.writeDouble(offsets[5], object.minPc);
  writer.writeString(offsets[6], object.stat);
}

StatRequirement _statRequirementDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StatRequirement();
  object.ignoreAndroid = reader
          .readByteList(offsets[0])
          ?.map((e) =>
              _StatRequirementignoreAndroidValueEnumMap[e] ??
              PerformanceRatings.excellent)
          .toList() ??
      [];
  object.ignorePc = reader
          .readByteList(offsets[1])
          ?.map((e) =>
              _StatRequirementignorePcValueEnumMap[e] ??
              PerformanceRatings.excellent)
          .toList() ??
      [];
  object.maxAndroid = reader.readDoubleOrNull(offsets[2]);
  object.maxPc = reader.readDoubleOrNull(offsets[3]);
  object.minAndroid = reader.readDoubleOrNull(offsets[4]);
  object.minPc = reader.readDoubleOrNull(offsets[5]);
  object.stat = reader.readString(offsets[6]);
  return object;
}

P _statRequirementDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader
              .readByteList(offset)
              ?.map((e) =>
                  _StatRequirementignoreAndroidValueEnumMap[e] ??
                  PerformanceRatings.excellent)
              .toList() ??
          []) as P;
    case 1:
      return (reader
              .readByteList(offset)
              ?.map((e) =>
                  _StatRequirementignorePcValueEnumMap[e] ??
                  PerformanceRatings.excellent)
              .toList() ??
          []) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _StatRequirementignoreAndroidEnumValueMap = {
  'excellent': 0,
  'good': 1,
  'medium': 2,
  'none': 3,
  'poor': 4,
  'veryPoor': 5,
};
const _StatRequirementignoreAndroidValueEnumMap = {
  0: PerformanceRatings.excellent,
  1: PerformanceRatings.good,
  2: PerformanceRatings.medium,
  3: PerformanceRatings.none,
  4: PerformanceRatings.poor,
  5: PerformanceRatings.veryPoor,
};
const _StatRequirementignorePcEnumValueMap = {
  'excellent': 0,
  'good': 1,
  'medium': 2,
  'none': 3,
  'poor': 4,
  'veryPoor': 5,
};
const _StatRequirementignorePcValueEnumMap = {
  0: PerformanceRatings.excellent,
  1: PerformanceRatings.good,
  2: PerformanceRatings.medium,
  3: PerformanceRatings.none,
  4: PerformanceRatings.poor,
  5: PerformanceRatings.veryPoor,
};

extension StatRequirementQueryFilter
    on QueryBuilder<StatRequirement, StatRequirement, QFilterCondition> {
  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignoreAndroidElementEqualTo(PerformanceRatings value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ignoreAndroid',
        value: value,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignoreAndroidElementGreaterThan(
    PerformanceRatings value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ignoreAndroid',
        value: value,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignoreAndroidElementLessThan(
    PerformanceRatings value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ignoreAndroid',
        value: value,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignoreAndroidElementBetween(
    PerformanceRatings lower,
    PerformanceRatings upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ignoreAndroid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignoreAndroidLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroid',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignoreAndroidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroid',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignoreAndroidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroid',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignoreAndroidLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroid',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignoreAndroidLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroid',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignoreAndroidLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignoreAndroid',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignorePcElementEqualTo(PerformanceRatings value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ignorePc',
        value: value,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignorePcElementGreaterThan(
    PerformanceRatings value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ignorePc',
        value: value,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignorePcElementLessThan(
    PerformanceRatings value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ignorePc',
        value: value,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignorePcElementBetween(
    PerformanceRatings lower,
    PerformanceRatings upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ignorePc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignorePcLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePc',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignorePcIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePc',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignorePcIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePc',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignorePcLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePc',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignorePcLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePc',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      ignorePcLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ignorePc',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxAndroidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxAndroid',
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxAndroidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxAndroid',
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxAndroidEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxAndroid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxAndroidGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxAndroid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxAndroidLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxAndroid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxAndroidBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxAndroid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxPcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxPc',
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxPcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxPc',
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxPcEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxPc',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxPcGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxPc',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxPcLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxPc',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      maxPcBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxPc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minAndroidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minAndroid',
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minAndroidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minAndroid',
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minAndroidEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minAndroid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minAndroidGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minAndroid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minAndroidLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minAndroid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minAndroidBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minAndroid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minPcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minPc',
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minPcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minPc',
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minPcEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minPc',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minPcGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minPc',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minPcLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minPc',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      minPcBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minPc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      statEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      statGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      statLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      statBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      statStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      statEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      statContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stat',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      statMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stat',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      statIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stat',
        value: '',
      ));
    });
  }

  QueryBuilder<StatRequirement, StatRequirement, QAfterFilterCondition>
      statIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stat',
        value: '',
      ));
    });
  }
}

extension StatRequirementQueryObject
    on QueryBuilder<StatRequirement, StatRequirement, QFilterCondition> {}
