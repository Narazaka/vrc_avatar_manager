// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_package_information_v2.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAvatarPackageInformationV2Collection on Isar {
  IsarCollection<AvatarPackageInformationV2> get avatarPackageInformationV2s =>
      this.collection();
}

const AvatarPackageInformationV2Schema = CollectionSchema(
  name: r'AvatarPackageInformationV2',
  id: 5480483663825639723,
  properties: {
    r'avatarId': PropertySchema(
      id: 0,
      name: r'avatarId',
      type: IsarType.string,
    ),
    r'platform': PropertySchema(
      id: 1,
      name: r'platform',
      type: IsarType.string,
    ),
    r'size': PropertySchema(
      id: 2,
      name: r'size',
      type: IsarType.long,
    ),
    r'unityPackageId': PropertySchema(
      id: 3,
      name: r'unityPackageId',
      type: IsarType.string,
    ),
    r'version': PropertySchema(
      id: 4,
      name: r'version',
      type: IsarType.long,
    )
  },
  estimateSize: _avatarPackageInformationV2EstimateSize,
  serialize: _avatarPackageInformationV2Serialize,
  deserialize: _avatarPackageInformationV2Deserialize,
  deserializeProp: _avatarPackageInformationV2DeserializeProp,
  idName: r'id',
  indexes: {
    r'avatarId_platform': IndexSchema(
      id: 5510269998660037278,
      name: r'avatarId_platform',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'avatarId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'platform',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _avatarPackageInformationV2GetId,
  getLinks: _avatarPackageInformationV2GetLinks,
  attach: _avatarPackageInformationV2Attach,
  version: '3.1.0+1',
);

int _avatarPackageInformationV2EstimateSize(
  AvatarPackageInformationV2 object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.avatarId.length * 3;
  bytesCount += 3 + object.platform.length * 3;
  bytesCount += 3 + object.unityPackageId.length * 3;
  return bytesCount;
}

void _avatarPackageInformationV2Serialize(
  AvatarPackageInformationV2 object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.avatarId);
  writer.writeString(offsets[1], object.platform);
  writer.writeLong(offsets[2], object.size);
  writer.writeString(offsets[3], object.unityPackageId);
  writer.writeLong(offsets[4], object.version);
}

AvatarPackageInformationV2 _avatarPackageInformationV2Deserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AvatarPackageInformationV2();
  object.avatarId = reader.readString(offsets[0]);
  object.id = id;
  object.platform = reader.readString(offsets[1]);
  object.size = reader.readLong(offsets[2]);
  object.unityPackageId = reader.readString(offsets[3]);
  object.version = reader.readLong(offsets[4]);
  return object;
}

P _avatarPackageInformationV2DeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _avatarPackageInformationV2GetId(AvatarPackageInformationV2 object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _avatarPackageInformationV2GetLinks(
    AvatarPackageInformationV2 object) {
  return [];
}

void _avatarPackageInformationV2Attach(
    IsarCollection<dynamic> col, Id id, AvatarPackageInformationV2 object) {
  object.id = id;
}

extension AvatarPackageInformationV2ByIndex
    on IsarCollection<AvatarPackageInformationV2> {
  Future<AvatarPackageInformationV2?> getByAvatarIdPlatform(
      String avatarId, String platform) {
    return getByIndex(r'avatarId_platform', [avatarId, platform]);
  }

  AvatarPackageInformationV2? getByAvatarIdPlatformSync(
      String avatarId, String platform) {
    return getByIndexSync(r'avatarId_platform', [avatarId, platform]);
  }

  Future<bool> deleteByAvatarIdPlatform(String avatarId, String platform) {
    return deleteByIndex(r'avatarId_platform', [avatarId, platform]);
  }

  bool deleteByAvatarIdPlatformSync(String avatarId, String platform) {
    return deleteByIndexSync(r'avatarId_platform', [avatarId, platform]);
  }

  Future<List<AvatarPackageInformationV2?>> getAllByAvatarIdPlatform(
      List<String> avatarIdValues, List<String> platformValues) {
    final len = avatarIdValues.length;
    assert(platformValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([avatarIdValues[i], platformValues[i]]);
    }

    return getAllByIndex(r'avatarId_platform', values);
  }

  List<AvatarPackageInformationV2?> getAllByAvatarIdPlatformSync(
      List<String> avatarIdValues, List<String> platformValues) {
    final len = avatarIdValues.length;
    assert(platformValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([avatarIdValues[i], platformValues[i]]);
    }

    return getAllByIndexSync(r'avatarId_platform', values);
  }

  Future<int> deleteAllByAvatarIdPlatform(
      List<String> avatarIdValues, List<String> platformValues) {
    final len = avatarIdValues.length;
    assert(platformValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([avatarIdValues[i], platformValues[i]]);
    }

    return deleteAllByIndex(r'avatarId_platform', values);
  }

  int deleteAllByAvatarIdPlatformSync(
      List<String> avatarIdValues, List<String> platformValues) {
    final len = avatarIdValues.length;
    assert(platformValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([avatarIdValues[i], platformValues[i]]);
    }

    return deleteAllByIndexSync(r'avatarId_platform', values);
  }

  Future<Id> putByAvatarIdPlatform(AvatarPackageInformationV2 object) {
    return putByIndex(r'avatarId_platform', object);
  }

  Id putByAvatarIdPlatformSync(AvatarPackageInformationV2 object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'avatarId_platform', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByAvatarIdPlatform(
      List<AvatarPackageInformationV2> objects) {
    return putAllByIndex(r'avatarId_platform', objects);
  }

  List<Id> putAllByAvatarIdPlatformSync(
      List<AvatarPackageInformationV2> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'avatarId_platform', objects,
        saveLinks: saveLinks);
  }
}

extension AvatarPackageInformationV2QueryWhereSort on QueryBuilder<
    AvatarPackageInformationV2, AvatarPackageInformationV2, QWhere> {
  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AvatarPackageInformationV2QueryWhere on QueryBuilder<
    AvatarPackageInformationV2, AvatarPackageInformationV2, QWhereClause> {
  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterWhereClause> idBetween(
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

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterWhereClause> avatarIdEqualToAnyPlatform(String avatarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'avatarId_platform',
        value: [avatarId],
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterWhereClause> avatarIdNotEqualToAnyPlatform(String avatarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarId_platform',
              lower: [],
              upper: [avatarId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarId_platform',
              lower: [avatarId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarId_platform',
              lower: [avatarId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarId_platform',
              lower: [],
              upper: [avatarId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
          QAfterWhereClause>
      avatarIdPlatformEqualTo(String avatarId, String platform) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'avatarId_platform',
        value: [avatarId, platform],
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
          QAfterWhereClause>
      avatarIdEqualToPlatformNotEqualTo(String avatarId, String platform) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarId_platform',
              lower: [avatarId],
              upper: [avatarId, platform],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarId_platform',
              lower: [avatarId, platform],
              includeLower: false,
              upper: [avatarId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarId_platform',
              lower: [avatarId, platform],
              includeLower: false,
              upper: [avatarId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'avatarId_platform',
              lower: [avatarId],
              upper: [avatarId, platform],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AvatarPackageInformationV2QueryFilter on QueryBuilder<
    AvatarPackageInformationV2, AvatarPackageInformationV2, QFilterCondition> {
  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> avatarIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> avatarIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> avatarIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> avatarIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> avatarIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> avatarIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
          QAfterFilterCondition>
      avatarIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
          QAfterFilterCondition>
      avatarIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> avatarIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarId',
        value: '',
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> avatarIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarId',
        value: '',
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> platformEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'platform',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> platformGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'platform',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> platformLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'platform',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> platformBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'platform',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> platformStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'platform',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> platformEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'platform',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
          QAfterFilterCondition>
      platformContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'platform',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
          QAfterFilterCondition>
      platformMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'platform',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> platformIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'platform',
        value: '',
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> platformIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'platform',
        value: '',
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> sizeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> sizeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> sizeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> sizeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> unityPackageIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unityPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> unityPackageIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unityPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> unityPackageIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unityPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> unityPackageIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unityPackageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> unityPackageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unityPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> unityPackageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unityPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
          QAfterFilterCondition>
      unityPackageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unityPackageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
          QAfterFilterCondition>
      unityPackageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unityPackageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> unityPackageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unityPackageId',
        value: '',
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> unityPackageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unityPackageId',
        value: '',
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> versionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> versionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterFilterCondition> versionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AvatarPackageInformationV2QueryObject on QueryBuilder<
    AvatarPackageInformationV2, AvatarPackageInformationV2, QFilterCondition> {}

extension AvatarPackageInformationV2QueryLinks on QueryBuilder<
    AvatarPackageInformationV2, AvatarPackageInformationV2, QFilterCondition> {}

extension AvatarPackageInformationV2QuerySortBy on QueryBuilder<
    AvatarPackageInformationV2, AvatarPackageInformationV2, QSortBy> {
  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> sortByAvatarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> sortByAvatarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> sortByPlatform() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platform', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> sortByPlatformDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platform', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> sortBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> sortBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> sortByUnityPackageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unityPackageId', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> sortByUnityPackageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unityPackageId', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension AvatarPackageInformationV2QuerySortThenBy on QueryBuilder<
    AvatarPackageInformationV2, AvatarPackageInformationV2, QSortThenBy> {
  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenByAvatarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenByAvatarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarId', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenByPlatform() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platform', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenByPlatformDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'platform', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenByUnityPackageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unityPackageId', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenByUnityPackageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unityPackageId', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension AvatarPackageInformationV2QueryWhereDistinct on QueryBuilder<
    AvatarPackageInformationV2, AvatarPackageInformationV2, QDistinct> {
  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QDistinct> distinctByAvatarId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QDistinct> distinctByPlatform({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'platform', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QDistinct> distinctBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'size');
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QDistinct> distinctByUnityPackageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unityPackageId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AvatarPackageInformationV2, AvatarPackageInformationV2,
      QDistinct> distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension AvatarPackageInformationV2QueryProperty on QueryBuilder<
    AvatarPackageInformationV2, AvatarPackageInformationV2, QQueryProperty> {
  QueryBuilder<AvatarPackageInformationV2, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AvatarPackageInformationV2, String, QQueryOperations>
      avatarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarId');
    });
  }

  QueryBuilder<AvatarPackageInformationV2, String, QQueryOperations>
      platformProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'platform');
    });
  }

  QueryBuilder<AvatarPackageInformationV2, int, QQueryOperations>
      sizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'size');
    });
  }

  QueryBuilder<AvatarPackageInformationV2, String, QQueryOperations>
      unityPackageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unityPackageId');
    });
  }

  QueryBuilder<AvatarPackageInformationV2, int, QQueryOperations>
      versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}
