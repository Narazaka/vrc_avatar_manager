// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_package_information.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAvatarPackageInformationCollection on Isar {
  IsarCollection<AvatarPackageInformation> get avatarPackageInformations =>
      this.collection();
}

const AvatarPackageInformationSchema = CollectionSchema(
  name: r'AvatarPackageInformation',
  id: 7039274160979277302,
  properties: {
    r'size': PropertySchema(
      id: 0,
      name: r'size',
      type: IsarType.long,
    ),
    r'unityPackageId': PropertySchema(
      id: 1,
      name: r'unityPackageId',
      type: IsarType.string,
    ),
    r'version': PropertySchema(
      id: 2,
      name: r'version',
      type: IsarType.long,
    )
  },
  estimateSize: _avatarPackageInformationEstimateSize,
  serialize: _avatarPackageInformationSerialize,
  deserialize: _avatarPackageInformationDeserialize,
  deserializeProp: _avatarPackageInformationDeserializeProp,
  idName: r'id',
  indexes: {
    r'unityPackageId': IndexSchema(
      id: 1413956904760622669,
      name: r'unityPackageId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'unityPackageId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _avatarPackageInformationGetId,
  getLinks: _avatarPackageInformationGetLinks,
  attach: _avatarPackageInformationAttach,
  version: '3.1.0+1',
);

int _avatarPackageInformationEstimateSize(
  AvatarPackageInformation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.unityPackageId.length * 3;
  return bytesCount;
}

void _avatarPackageInformationSerialize(
  AvatarPackageInformation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.size);
  writer.writeString(offsets[1], object.unityPackageId);
  writer.writeLong(offsets[2], object.version);
}

AvatarPackageInformation _avatarPackageInformationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AvatarPackageInformation();
  object.id = id;
  object.size = reader.readLong(offsets[0]);
  object.unityPackageId = reader.readString(offsets[1]);
  object.version = reader.readLong(offsets[2]);
  return object;
}

P _avatarPackageInformationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _avatarPackageInformationGetId(AvatarPackageInformation object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _avatarPackageInformationGetLinks(
    AvatarPackageInformation object) {
  return [];
}

void _avatarPackageInformationAttach(
    IsarCollection<dynamic> col, Id id, AvatarPackageInformation object) {
  object.id = id;
}

extension AvatarPackageInformationByIndex
    on IsarCollection<AvatarPackageInformation> {
  Future<AvatarPackageInformation?> getByUnityPackageId(String unityPackageId) {
    return getByIndex(r'unityPackageId', [unityPackageId]);
  }

  AvatarPackageInformation? getByUnityPackageIdSync(String unityPackageId) {
    return getByIndexSync(r'unityPackageId', [unityPackageId]);
  }

  Future<bool> deleteByUnityPackageId(String unityPackageId) {
    return deleteByIndex(r'unityPackageId', [unityPackageId]);
  }

  bool deleteByUnityPackageIdSync(String unityPackageId) {
    return deleteByIndexSync(r'unityPackageId', [unityPackageId]);
  }

  Future<List<AvatarPackageInformation?>> getAllByUnityPackageId(
      List<String> unityPackageIdValues) {
    final values = unityPackageIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'unityPackageId', values);
  }

  List<AvatarPackageInformation?> getAllByUnityPackageIdSync(
      List<String> unityPackageIdValues) {
    final values = unityPackageIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'unityPackageId', values);
  }

  Future<int> deleteAllByUnityPackageId(List<String> unityPackageIdValues) {
    final values = unityPackageIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'unityPackageId', values);
  }

  int deleteAllByUnityPackageIdSync(List<String> unityPackageIdValues) {
    final values = unityPackageIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'unityPackageId', values);
  }

  Future<Id> putByUnityPackageId(AvatarPackageInformation object) {
    return putByIndex(r'unityPackageId', object);
  }

  Id putByUnityPackageIdSync(AvatarPackageInformation object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'unityPackageId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUnityPackageId(
      List<AvatarPackageInformation> objects) {
    return putAllByIndex(r'unityPackageId', objects);
  }

  List<Id> putAllByUnityPackageIdSync(List<AvatarPackageInformation> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'unityPackageId', objects, saveLinks: saveLinks);
  }
}

extension AvatarPackageInformationQueryWhereSort on QueryBuilder<
    AvatarPackageInformation, AvatarPackageInformation, QWhere> {
  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AvatarPackageInformationQueryWhere on QueryBuilder<
    AvatarPackageInformation, AvatarPackageInformation, QWhereClause> {
  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
      QAfterWhereClause> unityPackageIdEqualTo(String unityPackageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'unityPackageId',
        value: [unityPackageId],
      ));
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
      QAfterWhereClause> unityPackageIdNotEqualTo(String unityPackageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'unityPackageId',
              lower: [],
              upper: [unityPackageId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'unityPackageId',
              lower: [unityPackageId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'unityPackageId',
              lower: [unityPackageId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'unityPackageId',
              lower: [],
              upper: [unityPackageId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension AvatarPackageInformationQueryFilter on QueryBuilder<
    AvatarPackageInformation, AvatarPackageInformation, QFilterCondition> {
  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
      QAfterFilterCondition> sizeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
      QAfterFilterCondition> unityPackageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unityPackageId',
        value: '',
      ));
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
      QAfterFilterCondition> unityPackageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unityPackageId',
        value: '',
      ));
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
      QAfterFilterCondition> versionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
      ));
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation,
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

extension AvatarPackageInformationQueryObject on QueryBuilder<
    AvatarPackageInformation, AvatarPackageInformation, QFilterCondition> {}

extension AvatarPackageInformationQueryLinks on QueryBuilder<
    AvatarPackageInformation, AvatarPackageInformation, QFilterCondition> {}

extension AvatarPackageInformationQuerySortBy on QueryBuilder<
    AvatarPackageInformation, AvatarPackageInformation, QSortBy> {
  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      sortBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      sortBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      sortByUnityPackageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unityPackageId', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      sortByUnityPackageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unityPackageId', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension AvatarPackageInformationQuerySortThenBy on QueryBuilder<
    AvatarPackageInformation, AvatarPackageInformation, QSortThenBy> {
  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      thenBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      thenBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      thenByUnityPackageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unityPackageId', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      thenByUnityPackageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unityPackageId', Sort.desc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QAfterSortBy>
      thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension AvatarPackageInformationQueryWhereDistinct on QueryBuilder<
    AvatarPackageInformation, AvatarPackageInformation, QDistinct> {
  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QDistinct>
      distinctBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'size');
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QDistinct>
      distinctByUnityPackageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unityPackageId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AvatarPackageInformation, AvatarPackageInformation, QDistinct>
      distinctByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version');
    });
  }
}

extension AvatarPackageInformationQueryProperty on QueryBuilder<
    AvatarPackageInformation, AvatarPackageInformation, QQueryProperty> {
  QueryBuilder<AvatarPackageInformation, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AvatarPackageInformation, int, QQueryOperations> sizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'size');
    });
  }

  QueryBuilder<AvatarPackageInformation, String, QQueryOperations>
      unityPackageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unityPackageId');
    });
  }

  QueryBuilder<AvatarPackageInformation, int, QQueryOperations>
      versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}
