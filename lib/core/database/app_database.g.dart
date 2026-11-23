// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PokemonsTable extends Pokemons
    with TableInfo<$PokemonsTable, PokemonRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nationalDexNumberMeta = const VerificationMeta(
    'nationalDexNumber',
  );
  @override
  late final GeneratedColumn<int> nationalDexNumber = GeneratedColumn<int>(
    'national_dex_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artworkUrlMeta = const VerificationMeta(
    'artworkUrl',
  );
  @override
  late final GeneratedColumn<String> artworkUrl = GeneratedColumn<String>(
    'artwork_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _generationIdMeta = const VerificationMeta(
    'generationId',
  );
  @override
  late final GeneratedColumn<int> generationId = GeneratedColumn<int>(
    'generation_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _baseStatTotalMeta = const VerificationMeta(
    'baseStatTotal',
  );
  @override
  late final GeneratedColumn<int> baseStatTotal = GeneratedColumn<int>(
    'base_stat_total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nationalDexNumber,
    imageUrl,
    artworkUrl,
    generationId,
    baseStatTotal,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemons';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('national_dex_number')) {
      context.handle(
        _nationalDexNumberMeta,
        nationalDexNumber.isAcceptableOrUnknown(
          data['national_dex_number']!,
          _nationalDexNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nationalDexNumberMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('artwork_url')) {
      context.handle(
        _artworkUrlMeta,
        artworkUrl.isAcceptableOrUnknown(data['artwork_url']!, _artworkUrlMeta),
      );
    }
    if (data.containsKey('generation_id')) {
      context.handle(
        _generationIdMeta,
        generationId.isAcceptableOrUnknown(
          data['generation_id']!,
          _generationIdMeta,
        ),
      );
    }
    if (data.containsKey('base_stat_total')) {
      context.handle(
        _baseStatTotalMeta,
        baseStatTotal.isAcceptableOrUnknown(
          data['base_stat_total']!,
          _baseStatTotalMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PokemonRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nationalDexNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}national_dex_number'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      artworkUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork_url'],
      ),
      generationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generation_id'],
      ),
      baseStatTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_stat_total'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PokemonsTable createAlias(String alias) {
    return $PokemonsTable(attachedDatabase, alias);
  }
}

class PokemonRow extends DataClass implements Insertable<PokemonRow> {
  final int id;
  final String name;
  final int nationalDexNumber;
  final String? imageUrl;
  final String? artworkUrl;
  final int? generationId;
  final int baseStatTotal;
  final DateTime updatedAt;
  const PokemonRow({
    required this.id,
    required this.name,
    required this.nationalDexNumber,
    this.imageUrl,
    this.artworkUrl,
    this.generationId,
    required this.baseStatTotal,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['national_dex_number'] = Variable<int>(nationalDexNumber);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || artworkUrl != null) {
      map['artwork_url'] = Variable<String>(artworkUrl);
    }
    if (!nullToAbsent || generationId != null) {
      map['generation_id'] = Variable<int>(generationId);
    }
    map['base_stat_total'] = Variable<int>(baseStatTotal);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PokemonsCompanion toCompanion(bool nullToAbsent) {
    return PokemonsCompanion(
      id: Value(id),
      name: Value(name),
      nationalDexNumber: Value(nationalDexNumber),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      artworkUrl: artworkUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkUrl),
      generationId: generationId == null && nullToAbsent
          ? const Value.absent()
          : Value(generationId),
      baseStatTotal: Value(baseStatTotal),
      updatedAt: Value(updatedAt),
    );
  }

  factory PokemonRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nationalDexNumber: serializer.fromJson<int>(json['nationalDexNumber']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      artworkUrl: serializer.fromJson<String?>(json['artworkUrl']),
      generationId: serializer.fromJson<int?>(json['generationId']),
      baseStatTotal: serializer.fromJson<int>(json['baseStatTotal']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nationalDexNumber': serializer.toJson<int>(nationalDexNumber),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'artworkUrl': serializer.toJson<String?>(artworkUrl),
      'generationId': serializer.toJson<int?>(generationId),
      'baseStatTotal': serializer.toJson<int>(baseStatTotal),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PokemonRow copyWith({
    int? id,
    String? name,
    int? nationalDexNumber,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> artworkUrl = const Value.absent(),
    Value<int?> generationId = const Value.absent(),
    int? baseStatTotal,
    DateTime? updatedAt,
  }) => PokemonRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nationalDexNumber: nationalDexNumber ?? this.nationalDexNumber,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    artworkUrl: artworkUrl.present ? artworkUrl.value : this.artworkUrl,
    generationId: generationId.present ? generationId.value : this.generationId,
    baseStatTotal: baseStatTotal ?? this.baseStatTotal,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PokemonRow copyWithCompanion(PokemonsCompanion data) {
    return PokemonRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nationalDexNumber: data.nationalDexNumber.present
          ? data.nationalDexNumber.value
          : this.nationalDexNumber,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      artworkUrl: data.artworkUrl.present
          ? data.artworkUrl.value
          : this.artworkUrl,
      generationId: data.generationId.present
          ? data.generationId.value
          : this.generationId,
      baseStatTotal: data.baseStatTotal.present
          ? data.baseStatTotal.value
          : this.baseStatTotal,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nationalDexNumber: $nationalDexNumber, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('generationId: $generationId, ')
          ..write('baseStatTotal: $baseStatTotal, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    nationalDexNumber,
    imageUrl,
    artworkUrl,
    generationId,
    baseStatTotal,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nationalDexNumber == this.nationalDexNumber &&
          other.imageUrl == this.imageUrl &&
          other.artworkUrl == this.artworkUrl &&
          other.generationId == this.generationId &&
          other.baseStatTotal == this.baseStatTotal &&
          other.updatedAt == this.updatedAt);
}

class PokemonsCompanion extends UpdateCompanion<PokemonRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> nationalDexNumber;
  final Value<String?> imageUrl;
  final Value<String?> artworkUrl;
  final Value<int?> generationId;
  final Value<int> baseStatTotal;
  final Value<DateTime> updatedAt;
  const PokemonsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nationalDexNumber = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.generationId = const Value.absent(),
    this.baseStatTotal = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PokemonsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int nationalDexNumber,
    this.imageUrl = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.generationId = const Value.absent(),
    this.baseStatTotal = const Value.absent(),
    required DateTime updatedAt,
  }) : name = Value(name),
       nationalDexNumber = Value(nationalDexNumber),
       updatedAt = Value(updatedAt);
  static Insertable<PokemonRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? nationalDexNumber,
    Expression<String>? imageUrl,
    Expression<String>? artworkUrl,
    Expression<int>? generationId,
    Expression<int>? baseStatTotal,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nationalDexNumber != null) 'national_dex_number': nationalDexNumber,
      if (imageUrl != null) 'image_url': imageUrl,
      if (artworkUrl != null) 'artwork_url': artworkUrl,
      if (generationId != null) 'generation_id': generationId,
      if (baseStatTotal != null) 'base_stat_total': baseStatTotal,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PokemonsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? nationalDexNumber,
    Value<String?>? imageUrl,
    Value<String?>? artworkUrl,
    Value<int?>? generationId,
    Value<int>? baseStatTotal,
    Value<DateTime>? updatedAt,
  }) {
    return PokemonsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nationalDexNumber: nationalDexNumber ?? this.nationalDexNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      generationId: generationId ?? this.generationId,
      baseStatTotal: baseStatTotal ?? this.baseStatTotal,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nationalDexNumber.present) {
      map['national_dex_number'] = Variable<int>(nationalDexNumber.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (artworkUrl.present) {
      map['artwork_url'] = Variable<String>(artworkUrl.value);
    }
    if (generationId.present) {
      map['generation_id'] = Variable<int>(generationId.value);
    }
    if (baseStatTotal.present) {
      map['base_stat_total'] = Variable<int>(baseStatTotal.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nationalDexNumber: $nationalDexNumber, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('generationId: $generationId, ')
          ..write('baseStatTotal: $baseStatTotal, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TypesTable extends Types with TableInfo<$TypesTable, TypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'types';
  @override
  VerificationContext validateIntegrity(
    Insertable<TypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TypeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $TypesTable createAlias(String alias) {
    return $TypesTable(attachedDatabase, alias);
  }
}

class TypeRow extends DataClass implements Insertable<TypeRow> {
  final int id;
  final String name;
  const TypeRow({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TypesCompanion toCompanion(bool nullToAbsent) {
    return TypesCompanion(id: Value(id), name: Value(name));
  }

  factory TypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TypeRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  TypeRow copyWith({int? id, String? name}) =>
      TypeRow(id: id ?? this.id, name: name ?? this.name);
  TypeRow copyWithCompanion(TypesCompanion data) {
    return TypeRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TypeRow(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TypeRow && other.id == this.id && other.name == this.name);
}

class TypesCompanion extends UpdateCompanion<TypeRow> {
  final Value<int> id;
  final Value<String> name;
  const TypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TypesCompanion.insert({this.id = const Value.absent(), required String name})
    : name = Value(name);
  static Insertable<TypeRow> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  TypesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return TypesCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PokemonTypesTable extends PokemonTypes
    with TableInfo<$PokemonTypesTable, PokemonTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemons (id)',
    ),
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES types (id)',
    ),
  );
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<int> slot = GeneratedColumn<int>(
    'slot',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, typeId, slot];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
        _slotMeta,
        slot.isAcceptableOrUnknown(data['slot']!, _slotMeta),
      );
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, typeId};
  @override
  PokemonTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonTypeRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type_id'],
      )!,
      slot: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot'],
      )!,
    );
  }

  @override
  $PokemonTypesTable createAlias(String alias) {
    return $PokemonTypesTable(attachedDatabase, alias);
  }
}

class PokemonTypeRow extends DataClass implements Insertable<PokemonTypeRow> {
  final int pokemonId;
  final int typeId;
  final int slot;
  const PokemonTypeRow({
    required this.pokemonId,
    required this.typeId,
    required this.slot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['type_id'] = Variable<int>(typeId);
    map['slot'] = Variable<int>(slot);
    return map;
  }

  PokemonTypesCompanion toCompanion(bool nullToAbsent) {
    return PokemonTypesCompanion(
      pokemonId: Value(pokemonId),
      typeId: Value(typeId),
      slot: Value(slot),
    );
  }

  factory PokemonTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonTypeRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      typeId: serializer.fromJson<int>(json['typeId']),
      slot: serializer.fromJson<int>(json['slot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'typeId': serializer.toJson<int>(typeId),
      'slot': serializer.toJson<int>(slot),
    };
  }

  PokemonTypeRow copyWith({int? pokemonId, int? typeId, int? slot}) =>
      PokemonTypeRow(
        pokemonId: pokemonId ?? this.pokemonId,
        typeId: typeId ?? this.typeId,
        slot: slot ?? this.slot,
      );
  PokemonTypeRow copyWithCompanion(PokemonTypesCompanion data) {
    return PokemonTypeRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      slot: data.slot.present ? data.slot.value : this.slot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypeRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, typeId, slot);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonTypeRow &&
          other.pokemonId == this.pokemonId &&
          other.typeId == this.typeId &&
          other.slot == this.slot);
}

class PokemonTypesCompanion extends UpdateCompanion<PokemonTypeRow> {
  final Value<int> pokemonId;
  final Value<int> typeId;
  final Value<int> slot;
  final Value<int> rowid;
  const PokemonTypesCompanion({
    this.pokemonId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.slot = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonTypesCompanion.insert({
    required int pokemonId,
    required int typeId,
    required int slot,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       typeId = Value(typeId),
       slot = Value(slot);
  static Insertable<PokemonTypeRow> custom({
    Expression<int>? pokemonId,
    Expression<int>? typeId,
    Expression<int>? slot,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (typeId != null) 'type_id': typeId,
      if (slot != null) 'slot': slot,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonTypesCompanion copyWith({
    Value<int>? pokemonId,
    Value<int>? typeId,
    Value<int>? slot,
    Value<int>? rowid,
  }) {
    return PokemonTypesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      typeId: typeId ?? this.typeId,
      slot: slot ?? this.slot,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<int>(slot.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonTypesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('typeId: $typeId, ')
          ..write('slot: $slot, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PokemonStatsTable extends PokemonStats
    with TableInfo<$PokemonStatsTable, PokemonStatRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemons (id)',
    ),
  );
  static const VerificationMeta _statNameMeta = const VerificationMeta(
    'statName',
  );
  @override
  late final GeneratedColumn<String> statName = GeneratedColumn<String>(
    'stat_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseStatMeta = const VerificationMeta(
    'baseStat',
  );
  @override
  late final GeneratedColumn<int> baseStat = GeneratedColumn<int>(
    'base_stat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, statName, baseStat];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonStatRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('stat_name')) {
      context.handle(
        _statNameMeta,
        statName.isAcceptableOrUnknown(data['stat_name']!, _statNameMeta),
      );
    } else if (isInserting) {
      context.missing(_statNameMeta);
    }
    if (data.containsKey('base_stat')) {
      context.handle(
        _baseStatMeta,
        baseStat.isAcceptableOrUnknown(data['base_stat']!, _baseStatMeta),
      );
    } else if (isInserting) {
      context.missing(_baseStatMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId, statName};
  @override
  PokemonStatRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonStatRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      statName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stat_name'],
      )!,
      baseStat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_stat'],
      )!,
    );
  }

  @override
  $PokemonStatsTable createAlias(String alias) {
    return $PokemonStatsTable(attachedDatabase, alias);
  }
}

class PokemonStatRow extends DataClass implements Insertable<PokemonStatRow> {
  final int pokemonId;
  final String statName;
  final int baseStat;
  const PokemonStatRow({
    required this.pokemonId,
    required this.statName,
    required this.baseStat,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['stat_name'] = Variable<String>(statName);
    map['base_stat'] = Variable<int>(baseStat);
    return map;
  }

  PokemonStatsCompanion toCompanion(bool nullToAbsent) {
    return PokemonStatsCompanion(
      pokemonId: Value(pokemonId),
      statName: Value(statName),
      baseStat: Value(baseStat),
    );
  }

  factory PokemonStatRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonStatRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      statName: serializer.fromJson<String>(json['statName']),
      baseStat: serializer.fromJson<int>(json['baseStat']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'statName': serializer.toJson<String>(statName),
      'baseStat': serializer.toJson<int>(baseStat),
    };
  }

  PokemonStatRow copyWith({int? pokemonId, String? statName, int? baseStat}) =>
      PokemonStatRow(
        pokemonId: pokemonId ?? this.pokemonId,
        statName: statName ?? this.statName,
        baseStat: baseStat ?? this.baseStat,
      );
  PokemonStatRow copyWithCompanion(PokemonStatsCompanion data) {
    return PokemonStatRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      statName: data.statName.present ? data.statName.value : this.statName,
      baseStat: data.baseStat.present ? data.baseStat.value : this.baseStat,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonStatRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('statName: $statName, ')
          ..write('baseStat: $baseStat')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, statName, baseStat);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonStatRow &&
          other.pokemonId == this.pokemonId &&
          other.statName == this.statName &&
          other.baseStat == this.baseStat);
}

class PokemonStatsCompanion extends UpdateCompanion<PokemonStatRow> {
  final Value<int> pokemonId;
  final Value<String> statName;
  final Value<int> baseStat;
  final Value<int> rowid;
  const PokemonStatsCompanion({
    this.pokemonId = const Value.absent(),
    this.statName = const Value.absent(),
    this.baseStat = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonStatsCompanion.insert({
    required int pokemonId,
    required String statName,
    required int baseStat,
    this.rowid = const Value.absent(),
  }) : pokemonId = Value(pokemonId),
       statName = Value(statName),
       baseStat = Value(baseStat);
  static Insertable<PokemonStatRow> custom({
    Expression<int>? pokemonId,
    Expression<String>? statName,
    Expression<int>? baseStat,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (statName != null) 'stat_name': statName,
      if (baseStat != null) 'base_stat': baseStat,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonStatsCompanion copyWith({
    Value<int>? pokemonId,
    Value<String>? statName,
    Value<int>? baseStat,
    Value<int>? rowid,
  }) {
    return PokemonStatsCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      statName: statName ?? this.statName,
      baseStat: baseStat ?? this.baseStat,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (statName.present) {
      map['stat_name'] = Variable<String>(statName.value);
    }
    if (baseStat.present) {
      map['base_stat'] = Variable<int>(baseStat.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonStatsCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('statName: $statName, ')
          ..write('baseStat: $baseStat, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pokemons (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [pokemonId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Favorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorite(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final int pokemonId;
  final DateTime createdAt;
  const Favorite({required this.pokemonId, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      pokemonId: Value(pokemonId),
      createdAt: Value(createdAt),
    );
  }

  factory Favorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Favorite copyWith({int? pokemonId, DateTime? createdAt}) => Favorite(
    pokemonId: pokemonId ?? this.pokemonId,
    createdAt: createdAt ?? this.createdAt,
  );
  Favorite copyWithCompanion(FavoritesCompanion data) {
    return Favorite(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('pokemonId: $pokemonId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pokemonId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.pokemonId == this.pokemonId &&
          other.createdAt == this.createdAt);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> pokemonId;
  final Value<DateTime> createdAt;
  const FavoritesCompanion({
    this.pokemonId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.pokemonId = const Value.absent(),
    required DateTime createdAt,
  }) : createdAt = Value(createdAt);
  static Insertable<Favorite> custom({
    Expression<int>? pokemonId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavoritesCompanion copyWith({
    Value<int>? pokemonId,
    Value<DateTime>? createdAt,
  }) {
    return FavoritesCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTable extends SyncMetadata
    with TableInfo<$SyncMetadataTable, SyncMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _resourceKeyMeta = const VerificationMeta(
    'resourceKey',
  );
  @override
  late final GeneratedColumn<String> resourceKey = GeneratedColumn<String>(
    'resource_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSuccessAtMeta = const VerificationMeta(
    'lastSuccessAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSuccessAt =
      GeneratedColumn<DateTime>(
        'last_success_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextOffsetMeta = const VerificationMeta(
    'nextOffset',
  );
  @override
  late final GeneratedColumn<int> nextOffset = GeneratedColumn<int>(
    'next_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    resourceKey,
    lastSuccessAt,
    status,
    nextOffset,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('resource_key')) {
      context.handle(
        _resourceKeyMeta,
        resourceKey.isAcceptableOrUnknown(
          data['resource_key']!,
          _resourceKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_resourceKeyMeta);
    }
    if (data.containsKey('last_success_at')) {
      context.handle(
        _lastSuccessAtMeta,
        lastSuccessAt.isAcceptableOrUnknown(
          data['last_success_at']!,
          _lastSuccessAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('next_offset')) {
      context.handle(
        _nextOffsetMeta,
        nextOffset.isAcceptableOrUnknown(data['next_offset']!, _nextOffsetMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {resourceKey};
  @override
  SyncMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataData(
      resourceKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resource_key'],
      )!,
      lastSuccessAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_success_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      nextOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_offset'],
      )!,
    );
  }

  @override
  $SyncMetadataTable createAlias(String alias) {
    return $SyncMetadataTable(attachedDatabase, alias);
  }
}

class SyncMetadataData extends DataClass
    implements Insertable<SyncMetadataData> {
  final String resourceKey;
  final DateTime? lastSuccessAt;
  final String status;
  final int nextOffset;
  const SyncMetadataData({
    required this.resourceKey,
    this.lastSuccessAt,
    required this.status,
    required this.nextOffset,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['resource_key'] = Variable<String>(resourceKey);
    if (!nullToAbsent || lastSuccessAt != null) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt);
    }
    map['status'] = Variable<String>(status);
    map['next_offset'] = Variable<int>(nextOffset);
    return map;
  }

  SyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataCompanion(
      resourceKey: Value(resourceKey),
      lastSuccessAt: lastSuccessAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessAt),
      status: Value(status),
      nextOffset: Value(nextOffset),
    );
  }

  factory SyncMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataData(
      resourceKey: serializer.fromJson<String>(json['resourceKey']),
      lastSuccessAt: serializer.fromJson<DateTime?>(json['lastSuccessAt']),
      status: serializer.fromJson<String>(json['status']),
      nextOffset: serializer.fromJson<int>(json['nextOffset']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'resourceKey': serializer.toJson<String>(resourceKey),
      'lastSuccessAt': serializer.toJson<DateTime?>(lastSuccessAt),
      'status': serializer.toJson<String>(status),
      'nextOffset': serializer.toJson<int>(nextOffset),
    };
  }

  SyncMetadataData copyWith({
    String? resourceKey,
    Value<DateTime?> lastSuccessAt = const Value.absent(),
    String? status,
    int? nextOffset,
  }) => SyncMetadataData(
    resourceKey: resourceKey ?? this.resourceKey,
    lastSuccessAt: lastSuccessAt.present
        ? lastSuccessAt.value
        : this.lastSuccessAt,
    status: status ?? this.status,
    nextOffset: nextOffset ?? this.nextOffset,
  );
  SyncMetadataData copyWithCompanion(SyncMetadataCompanion data) {
    return SyncMetadataData(
      resourceKey: data.resourceKey.present
          ? data.resourceKey.value
          : this.resourceKey,
      lastSuccessAt: data.lastSuccessAt.present
          ? data.lastSuccessAt.value
          : this.lastSuccessAt,
      status: data.status.present ? data.status.value : this.status,
      nextOffset: data.nextOffset.present
          ? data.nextOffset.value
          : this.nextOffset,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataData(')
          ..write('resourceKey: $resourceKey, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('status: $status, ')
          ..write('nextOffset: $nextOffset')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(resourceKey, lastSuccessAt, status, nextOffset);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataData &&
          other.resourceKey == this.resourceKey &&
          other.lastSuccessAt == this.lastSuccessAt &&
          other.status == this.status &&
          other.nextOffset == this.nextOffset);
}

class SyncMetadataCompanion extends UpdateCompanion<SyncMetadataData> {
  final Value<String> resourceKey;
  final Value<DateTime?> lastSuccessAt;
  final Value<String> status;
  final Value<int> nextOffset;
  final Value<int> rowid;
  const SyncMetadataCompanion({
    this.resourceKey = const Value.absent(),
    this.lastSuccessAt = const Value.absent(),
    this.status = const Value.absent(),
    this.nextOffset = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataCompanion.insert({
    required String resourceKey,
    this.lastSuccessAt = const Value.absent(),
    required String status,
    this.nextOffset = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : resourceKey = Value(resourceKey),
       status = Value(status);
  static Insertable<SyncMetadataData> custom({
    Expression<String>? resourceKey,
    Expression<DateTime>? lastSuccessAt,
    Expression<String>? status,
    Expression<int>? nextOffset,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (resourceKey != null) 'resource_key': resourceKey,
      if (lastSuccessAt != null) 'last_success_at': lastSuccessAt,
      if (status != null) 'status': status,
      if (nextOffset != null) 'next_offset': nextOffset,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataCompanion copyWith({
    Value<String>? resourceKey,
    Value<DateTime?>? lastSuccessAt,
    Value<String>? status,
    Value<int>? nextOffset,
    Value<int>? rowid,
  }) {
    return SyncMetadataCompanion(
      resourceKey: resourceKey ?? this.resourceKey,
      lastSuccessAt: lastSuccessAt ?? this.lastSuccessAt,
      status: status ?? this.status,
      nextOffset: nextOffset ?? this.nextOffset,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (resourceKey.present) {
      map['resource_key'] = Variable<String>(resourceKey.value);
    }
    if (lastSuccessAt.present) {
      map['last_success_at'] = Variable<DateTime>(lastSuccessAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (nextOffset.present) {
      map['next_offset'] = Variable<int>(nextOffset.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataCompanion(')
          ..write('resourceKey: $resourceKey, ')
          ..write('lastSuccessAt: $lastSuccessAt, ')
          ..write('status: $status, ')
          ..write('nextOffset: $nextOffset, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PokemonDetailsTable extends PokemonDetails
    with TableInfo<$PokemonDetailsTable, PokemonDetailRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pokemonIdMeta = const VerificationMeta(
    'pokemonId',
  );
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
    'pokemon_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alturaMeta = const VerificationMeta('altura');
  @override
  late final GeneratedColumn<int> altura = GeneratedColumn<int>(
    'altura',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pesoMeta = const VerificationMeta('peso');
  @override
  late final GeneratedColumn<int> peso = GeneratedColumn<int>(
    'peso',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spriteMeta = const VerificationMeta('sprite');
  @override
  late final GeneratedColumn<String> sprite = GeneratedColumn<String>(
    'sprite',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artworkMeta = const VerificationMeta(
    'artwork',
  );
  @override
  late final GeneratedColumn<String> artwork = GeneratedColumn<String>(
    'artwork',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spriteShinyMeta = const VerificationMeta(
    'spriteShiny',
  );
  @override
  late final GeneratedColumn<String> spriteShiny = GeneratedColumn<String>(
    'sprite_shiny',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artworkShinyMeta = const VerificationMeta(
    'artworkShiny',
  );
  @override
  late final GeneratedColumn<String> artworkShiny = GeneratedColumn<String>(
    'artwork_shiny',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tiposMeta = const VerificationMeta('tipos');
  @override
  late final GeneratedColumn<String> tipos = GeneratedColumn<String>(
    'tipos',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadisticasMeta = const VerificationMeta(
    'estadisticas',
  );
  @override
  late final GeneratedColumn<String> estadisticas = GeneratedColumn<String>(
    'estadisticas',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habilidadesMeta = const VerificationMeta(
    'habilidades',
  );
  @override
  late final GeneratedColumn<String> habilidades = GeneratedColumn<String>(
    'habilidades',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _movimientosMeta = const VerificationMeta(
    'movimientos',
  );
  @override
  late final GeneratedColumn<String> movimientos = GeneratedColumn<String>(
    'movimientos',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gruposHuevoMeta = const VerificationMeta(
    'gruposHuevo',
  );
  @override
  late final GeneratedColumn<String> gruposHuevo = GeneratedColumn<String>(
    'grupos_huevo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formasMeta = const VerificationMeta('formas');
  @override
  late final GeneratedColumn<String> formas = GeneratedColumn<String>(
    'formas',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _evolucionesMeta = const VerificationMeta(
    'evoluciones',
  );
  @override
  late final GeneratedColumn<String> evoluciones = GeneratedColumn<String>(
    'evoluciones',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualizadoEnMeta = const VerificationMeta(
    'actualizadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> actualizadoEn =
      GeneratedColumn<DateTime>(
        'actualizado_en',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    pokemonId,
    nombre,
    altura,
    peso,
    sprite,
    artwork,
    spriteShiny,
    artworkShiny,
    tipos,
    estadisticas,
    habilidades,
    movimientos,
    gruposHuevo,
    formas,
    evoluciones,
    actualizadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<PokemonDetailRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pokemon_id')) {
      context.handle(
        _pokemonIdMeta,
        pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta),
      );
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('altura')) {
      context.handle(
        _alturaMeta,
        altura.isAcceptableOrUnknown(data['altura']!, _alturaMeta),
      );
    } else if (isInserting) {
      context.missing(_alturaMeta);
    }
    if (data.containsKey('peso')) {
      context.handle(
        _pesoMeta,
        peso.isAcceptableOrUnknown(data['peso']!, _pesoMeta),
      );
    } else if (isInserting) {
      context.missing(_pesoMeta);
    }
    if (data.containsKey('sprite')) {
      context.handle(
        _spriteMeta,
        sprite.isAcceptableOrUnknown(data['sprite']!, _spriteMeta),
      );
    }
    if (data.containsKey('artwork')) {
      context.handle(
        _artworkMeta,
        artwork.isAcceptableOrUnknown(data['artwork']!, _artworkMeta),
      );
    }
    if (data.containsKey('sprite_shiny')) {
      context.handle(
        _spriteShinyMeta,
        spriteShiny.isAcceptableOrUnknown(
          data['sprite_shiny']!,
          _spriteShinyMeta,
        ),
      );
    }
    if (data.containsKey('artwork_shiny')) {
      context.handle(
        _artworkShinyMeta,
        artworkShiny.isAcceptableOrUnknown(
          data['artwork_shiny']!,
          _artworkShinyMeta,
        ),
      );
    }
    if (data.containsKey('tipos')) {
      context.handle(
        _tiposMeta,
        tipos.isAcceptableOrUnknown(data['tipos']!, _tiposMeta),
      );
    } else if (isInserting) {
      context.missing(_tiposMeta);
    }
    if (data.containsKey('estadisticas')) {
      context.handle(
        _estadisticasMeta,
        estadisticas.isAcceptableOrUnknown(
          data['estadisticas']!,
          _estadisticasMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estadisticasMeta);
    }
    if (data.containsKey('habilidades')) {
      context.handle(
        _habilidadesMeta,
        habilidades.isAcceptableOrUnknown(
          data['habilidades']!,
          _habilidadesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_habilidadesMeta);
    }
    if (data.containsKey('movimientos')) {
      context.handle(
        _movimientosMeta,
        movimientos.isAcceptableOrUnknown(
          data['movimientos']!,
          _movimientosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_movimientosMeta);
    }
    if (data.containsKey('grupos_huevo')) {
      context.handle(
        _gruposHuevoMeta,
        gruposHuevo.isAcceptableOrUnknown(
          data['grupos_huevo']!,
          _gruposHuevoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gruposHuevoMeta);
    }
    if (data.containsKey('formas')) {
      context.handle(
        _formasMeta,
        formas.isAcceptableOrUnknown(data['formas']!, _formasMeta),
      );
    } else if (isInserting) {
      context.missing(_formasMeta);
    }
    if (data.containsKey('evoluciones')) {
      context.handle(
        _evolucionesMeta,
        evoluciones.isAcceptableOrUnknown(
          data['evoluciones']!,
          _evolucionesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_evolucionesMeta);
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
        _actualizadoEnMeta,
        actualizadoEn.isAcceptableOrUnknown(
          data['actualizado_en']!,
          _actualizadoEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualizadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pokemonId};
  @override
  PokemonDetailRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonDetailRow(
      pokemonId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pokemon_id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      altura: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altura'],
      )!,
      peso: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}peso'],
      )!,
      sprite: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprite'],
      ),
      artwork: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork'],
      ),
      spriteShiny: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sprite_shiny'],
      ),
      artworkShiny: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artwork_shiny'],
      ),
      tipos: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipos'],
      )!,
      estadisticas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estadisticas'],
      )!,
      habilidades: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habilidades'],
      )!,
      movimientos: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}movimientos'],
      )!,
      gruposHuevo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grupos_huevo'],
      )!,
      formas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}formas'],
      )!,
      evoluciones: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}evoluciones'],
      )!,
      actualizadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actualizado_en'],
      )!,
    );
  }

  @override
  $PokemonDetailsTable createAlias(String alias) {
    return $PokemonDetailsTable(attachedDatabase, alias);
  }
}

class PokemonDetailRow extends DataClass
    implements Insertable<PokemonDetailRow> {
  final int pokemonId;
  final String nombre;
  final int altura;
  final int peso;
  final String? sprite;
  final String? artwork;
  final String? spriteShiny;
  final String? artworkShiny;
  final String tipos;
  final String estadisticas;
  final String habilidades;
  final String movimientos;
  final String gruposHuevo;
  final String formas;
  final String evoluciones;
  final DateTime actualizadoEn;
  const PokemonDetailRow({
    required this.pokemonId,
    required this.nombre,
    required this.altura,
    required this.peso,
    this.sprite,
    this.artwork,
    this.spriteShiny,
    this.artworkShiny,
    required this.tipos,
    required this.estadisticas,
    required this.habilidades,
    required this.movimientos,
    required this.gruposHuevo,
    required this.formas,
    required this.evoluciones,
    required this.actualizadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['nombre'] = Variable<String>(nombre);
    map['altura'] = Variable<int>(altura);
    map['peso'] = Variable<int>(peso);
    if (!nullToAbsent || sprite != null) {
      map['sprite'] = Variable<String>(sprite);
    }
    if (!nullToAbsent || artwork != null) {
      map['artwork'] = Variable<String>(artwork);
    }
    if (!nullToAbsent || spriteShiny != null) {
      map['sprite_shiny'] = Variable<String>(spriteShiny);
    }
    if (!nullToAbsent || artworkShiny != null) {
      map['artwork_shiny'] = Variable<String>(artworkShiny);
    }
    map['tipos'] = Variable<String>(tipos);
    map['estadisticas'] = Variable<String>(estadisticas);
    map['habilidades'] = Variable<String>(habilidades);
    map['movimientos'] = Variable<String>(movimientos);
    map['grupos_huevo'] = Variable<String>(gruposHuevo);
    map['formas'] = Variable<String>(formas);
    map['evoluciones'] = Variable<String>(evoluciones);
    map['actualizado_en'] = Variable<DateTime>(actualizadoEn);
    return map;
  }

  PokemonDetailsCompanion toCompanion(bool nullToAbsent) {
    return PokemonDetailsCompanion(
      pokemonId: Value(pokemonId),
      nombre: Value(nombre),
      altura: Value(altura),
      peso: Value(peso),
      sprite: sprite == null && nullToAbsent
          ? const Value.absent()
          : Value(sprite),
      artwork: artwork == null && nullToAbsent
          ? const Value.absent()
          : Value(artwork),
      spriteShiny: spriteShiny == null && nullToAbsent
          ? const Value.absent()
          : Value(spriteShiny),
      artworkShiny: artworkShiny == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkShiny),
      tipos: Value(tipos),
      estadisticas: Value(estadisticas),
      habilidades: Value(habilidades),
      movimientos: Value(movimientos),
      gruposHuevo: Value(gruposHuevo),
      formas: Value(formas),
      evoluciones: Value(evoluciones),
      actualizadoEn: Value(actualizadoEn),
    );
  }

  factory PokemonDetailRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PokemonDetailRow(
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      nombre: serializer.fromJson<String>(json['nombre']),
      altura: serializer.fromJson<int>(json['altura']),
      peso: serializer.fromJson<int>(json['peso']),
      sprite: serializer.fromJson<String?>(json['sprite']),
      artwork: serializer.fromJson<String?>(json['artwork']),
      spriteShiny: serializer.fromJson<String?>(json['spriteShiny']),
      artworkShiny: serializer.fromJson<String?>(json['artworkShiny']),
      tipos: serializer.fromJson<String>(json['tipos']),
      estadisticas: serializer.fromJson<String>(json['estadisticas']),
      habilidades: serializer.fromJson<String>(json['habilidades']),
      movimientos: serializer.fromJson<String>(json['movimientos']),
      gruposHuevo: serializer.fromJson<String>(json['gruposHuevo']),
      formas: serializer.fromJson<String>(json['formas']),
      evoluciones: serializer.fromJson<String>(json['evoluciones']),
      actualizadoEn: serializer.fromJson<DateTime>(json['actualizadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pokemonId': serializer.toJson<int>(pokemonId),
      'nombre': serializer.toJson<String>(nombre),
      'altura': serializer.toJson<int>(altura),
      'peso': serializer.toJson<int>(peso),
      'sprite': serializer.toJson<String?>(sprite),
      'artwork': serializer.toJson<String?>(artwork),
      'spriteShiny': serializer.toJson<String?>(spriteShiny),
      'artworkShiny': serializer.toJson<String?>(artworkShiny),
      'tipos': serializer.toJson<String>(tipos),
      'estadisticas': serializer.toJson<String>(estadisticas),
      'habilidades': serializer.toJson<String>(habilidades),
      'movimientos': serializer.toJson<String>(movimientos),
      'gruposHuevo': serializer.toJson<String>(gruposHuevo),
      'formas': serializer.toJson<String>(formas),
      'evoluciones': serializer.toJson<String>(evoluciones),
      'actualizadoEn': serializer.toJson<DateTime>(actualizadoEn),
    };
  }

  PokemonDetailRow copyWith({
    int? pokemonId,
    String? nombre,
    int? altura,
    int? peso,
    Value<String?> sprite = const Value.absent(),
    Value<String?> artwork = const Value.absent(),
    Value<String?> spriteShiny = const Value.absent(),
    Value<String?> artworkShiny = const Value.absent(),
    String? tipos,
    String? estadisticas,
    String? habilidades,
    String? movimientos,
    String? gruposHuevo,
    String? formas,
    String? evoluciones,
    DateTime? actualizadoEn,
  }) => PokemonDetailRow(
    pokemonId: pokemonId ?? this.pokemonId,
    nombre: nombre ?? this.nombre,
    altura: altura ?? this.altura,
    peso: peso ?? this.peso,
    sprite: sprite.present ? sprite.value : this.sprite,
    artwork: artwork.present ? artwork.value : this.artwork,
    spriteShiny: spriteShiny.present ? spriteShiny.value : this.spriteShiny,
    artworkShiny: artworkShiny.present ? artworkShiny.value : this.artworkShiny,
    tipos: tipos ?? this.tipos,
    estadisticas: estadisticas ?? this.estadisticas,
    habilidades: habilidades ?? this.habilidades,
    movimientos: movimientos ?? this.movimientos,
    gruposHuevo: gruposHuevo ?? this.gruposHuevo,
    formas: formas ?? this.formas,
    evoluciones: evoluciones ?? this.evoluciones,
    actualizadoEn: actualizadoEn ?? this.actualizadoEn,
  );
  PokemonDetailRow copyWithCompanion(PokemonDetailsCompanion data) {
    return PokemonDetailRow(
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      altura: data.altura.present ? data.altura.value : this.altura,
      peso: data.peso.present ? data.peso.value : this.peso,
      sprite: data.sprite.present ? data.sprite.value : this.sprite,
      artwork: data.artwork.present ? data.artwork.value : this.artwork,
      spriteShiny: data.spriteShiny.present
          ? data.spriteShiny.value
          : this.spriteShiny,
      artworkShiny: data.artworkShiny.present
          ? data.artworkShiny.value
          : this.artworkShiny,
      tipos: data.tipos.present ? data.tipos.value : this.tipos,
      estadisticas: data.estadisticas.present
          ? data.estadisticas.value
          : this.estadisticas,
      habilidades: data.habilidades.present
          ? data.habilidades.value
          : this.habilidades,
      movimientos: data.movimientos.present
          ? data.movimientos.value
          : this.movimientos,
      gruposHuevo: data.gruposHuevo.present
          ? data.gruposHuevo.value
          : this.gruposHuevo,
      formas: data.formas.present ? data.formas.value : this.formas,
      evoluciones: data.evoluciones.present
          ? data.evoluciones.value
          : this.evoluciones,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PokemonDetailRow(')
          ..write('pokemonId: $pokemonId, ')
          ..write('nombre: $nombre, ')
          ..write('altura: $altura, ')
          ..write('peso: $peso, ')
          ..write('sprite: $sprite, ')
          ..write('artwork: $artwork, ')
          ..write('spriteShiny: $spriteShiny, ')
          ..write('artworkShiny: $artworkShiny, ')
          ..write('tipos: $tipos, ')
          ..write('estadisticas: $estadisticas, ')
          ..write('habilidades: $habilidades, ')
          ..write('movimientos: $movimientos, ')
          ..write('gruposHuevo: $gruposHuevo, ')
          ..write('formas: $formas, ')
          ..write('evoluciones: $evoluciones, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    pokemonId,
    nombre,
    altura,
    peso,
    sprite,
    artwork,
    spriteShiny,
    artworkShiny,
    tipos,
    estadisticas,
    habilidades,
    movimientos,
    gruposHuevo,
    formas,
    evoluciones,
    actualizadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PokemonDetailRow &&
          other.pokemonId == this.pokemonId &&
          other.nombre == this.nombre &&
          other.altura == this.altura &&
          other.peso == this.peso &&
          other.sprite == this.sprite &&
          other.artwork == this.artwork &&
          other.spriteShiny == this.spriteShiny &&
          other.artworkShiny == this.artworkShiny &&
          other.tipos == this.tipos &&
          other.estadisticas == this.estadisticas &&
          other.habilidades == this.habilidades &&
          other.movimientos == this.movimientos &&
          other.gruposHuevo == this.gruposHuevo &&
          other.formas == this.formas &&
          other.evoluciones == this.evoluciones &&
          other.actualizadoEn == this.actualizadoEn);
}

class PokemonDetailsCompanion extends UpdateCompanion<PokemonDetailRow> {
  final Value<int> pokemonId;
  final Value<String> nombre;
  final Value<int> altura;
  final Value<int> peso;
  final Value<String?> sprite;
  final Value<String?> artwork;
  final Value<String?> spriteShiny;
  final Value<String?> artworkShiny;
  final Value<String> tipos;
  final Value<String> estadisticas;
  final Value<String> habilidades;
  final Value<String> movimientos;
  final Value<String> gruposHuevo;
  final Value<String> formas;
  final Value<String> evoluciones;
  final Value<DateTime> actualizadoEn;
  const PokemonDetailsCompanion({
    this.pokemonId = const Value.absent(),
    this.nombre = const Value.absent(),
    this.altura = const Value.absent(),
    this.peso = const Value.absent(),
    this.sprite = const Value.absent(),
    this.artwork = const Value.absent(),
    this.spriteShiny = const Value.absent(),
    this.artworkShiny = const Value.absent(),
    this.tipos = const Value.absent(),
    this.estadisticas = const Value.absent(),
    this.habilidades = const Value.absent(),
    this.movimientos = const Value.absent(),
    this.gruposHuevo = const Value.absent(),
    this.formas = const Value.absent(),
    this.evoluciones = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
  });
  PokemonDetailsCompanion.insert({
    this.pokemonId = const Value.absent(),
    required String nombre,
    required int altura,
    required int peso,
    this.sprite = const Value.absent(),
    this.artwork = const Value.absent(),
    this.spriteShiny = const Value.absent(),
    this.artworkShiny = const Value.absent(),
    required String tipos,
    required String estadisticas,
    required String habilidades,
    required String movimientos,
    required String gruposHuevo,
    required String formas,
    required String evoluciones,
    required DateTime actualizadoEn,
  }) : nombre = Value(nombre),
       altura = Value(altura),
       peso = Value(peso),
       tipos = Value(tipos),
       estadisticas = Value(estadisticas),
       habilidades = Value(habilidades),
       movimientos = Value(movimientos),
       gruposHuevo = Value(gruposHuevo),
       formas = Value(formas),
       evoluciones = Value(evoluciones),
       actualizadoEn = Value(actualizadoEn);
  static Insertable<PokemonDetailRow> custom({
    Expression<int>? pokemonId,
    Expression<String>? nombre,
    Expression<int>? altura,
    Expression<int>? peso,
    Expression<String>? sprite,
    Expression<String>? artwork,
    Expression<String>? spriteShiny,
    Expression<String>? artworkShiny,
    Expression<String>? tipos,
    Expression<String>? estadisticas,
    Expression<String>? habilidades,
    Expression<String>? movimientos,
    Expression<String>? gruposHuevo,
    Expression<String>? formas,
    Expression<String>? evoluciones,
    Expression<DateTime>? actualizadoEn,
  }) {
    return RawValuesInsertable({
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (nombre != null) 'nombre': nombre,
      if (altura != null) 'altura': altura,
      if (peso != null) 'peso': peso,
      if (sprite != null) 'sprite': sprite,
      if (artwork != null) 'artwork': artwork,
      if (spriteShiny != null) 'sprite_shiny': spriteShiny,
      if (artworkShiny != null) 'artwork_shiny': artworkShiny,
      if (tipos != null) 'tipos': tipos,
      if (estadisticas != null) 'estadisticas': estadisticas,
      if (habilidades != null) 'habilidades': habilidades,
      if (movimientos != null) 'movimientos': movimientos,
      if (gruposHuevo != null) 'grupos_huevo': gruposHuevo,
      if (formas != null) 'formas': formas,
      if (evoluciones != null) 'evoluciones': evoluciones,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
    });
  }

  PokemonDetailsCompanion copyWith({
    Value<int>? pokemonId,
    Value<String>? nombre,
    Value<int>? altura,
    Value<int>? peso,
    Value<String?>? sprite,
    Value<String?>? artwork,
    Value<String?>? spriteShiny,
    Value<String?>? artworkShiny,
    Value<String>? tipos,
    Value<String>? estadisticas,
    Value<String>? habilidades,
    Value<String>? movimientos,
    Value<String>? gruposHuevo,
    Value<String>? formas,
    Value<String>? evoluciones,
    Value<DateTime>? actualizadoEn,
  }) {
    return PokemonDetailsCompanion(
      pokemonId: pokemonId ?? this.pokemonId,
      nombre: nombre ?? this.nombre,
      altura: altura ?? this.altura,
      peso: peso ?? this.peso,
      sprite: sprite ?? this.sprite,
      artwork: artwork ?? this.artwork,
      spriteShiny: spriteShiny ?? this.spriteShiny,
      artworkShiny: artworkShiny ?? this.artworkShiny,
      tipos: tipos ?? this.tipos,
      estadisticas: estadisticas ?? this.estadisticas,
      habilidades: habilidades ?? this.habilidades,
      movimientos: movimientos ?? this.movimientos,
      gruposHuevo: gruposHuevo ?? this.gruposHuevo,
      formas: formas ?? this.formas,
      evoluciones: evoluciones ?? this.evoluciones,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (altura.present) {
      map['altura'] = Variable<int>(altura.value);
    }
    if (peso.present) {
      map['peso'] = Variable<int>(peso.value);
    }
    if (sprite.present) {
      map['sprite'] = Variable<String>(sprite.value);
    }
    if (artwork.present) {
      map['artwork'] = Variable<String>(artwork.value);
    }
    if (spriteShiny.present) {
      map['sprite_shiny'] = Variable<String>(spriteShiny.value);
    }
    if (artworkShiny.present) {
      map['artwork_shiny'] = Variable<String>(artworkShiny.value);
    }
    if (tipos.present) {
      map['tipos'] = Variable<String>(tipos.value);
    }
    if (estadisticas.present) {
      map['estadisticas'] = Variable<String>(estadisticas.value);
    }
    if (habilidades.present) {
      map['habilidades'] = Variable<String>(habilidades.value);
    }
    if (movimientos.present) {
      map['movimientos'] = Variable<String>(movimientos.value);
    }
    if (gruposHuevo.present) {
      map['grupos_huevo'] = Variable<String>(gruposHuevo.value);
    }
    if (formas.present) {
      map['formas'] = Variable<String>(formas.value);
    }
    if (evoluciones.present) {
      map['evoluciones'] = Variable<String>(evoluciones.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<DateTime>(actualizadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonDetailsCompanion(')
          ..write('pokemonId: $pokemonId, ')
          ..write('nombre: $nombre, ')
          ..write('altura: $altura, ')
          ..write('peso: $peso, ')
          ..write('sprite: $sprite, ')
          ..write('artwork: $artwork, ')
          ..write('spriteShiny: $spriteShiny, ')
          ..write('artworkShiny: $artworkShiny, ')
          ..write('tipos: $tipos, ')
          ..write('estadisticas: $estadisticas, ')
          ..write('habilidades: $habilidades, ')
          ..write('movimientos: $movimientos, ')
          ..write('gruposHuevo: $gruposHuevo, ')
          ..write('formas: $formas, ')
          ..write('evoluciones: $evoluciones, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PokemonsTable pokemons = $PokemonsTable(this);
  late final $TypesTable types = $TypesTable(this);
  late final $PokemonTypesTable pokemonTypes = $PokemonTypesTable(this);
  late final $PokemonStatsTable pokemonStats = $PokemonStatsTable(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $SyncMetadataTable syncMetadata = $SyncMetadataTable(this);
  late final $PokemonDetailsTable pokemonDetails = $PokemonDetailsTable(this);
  late final Index pokemonNameIdx = Index(
    'pokemon_name_idx',
    'CREATE INDEX pokemon_name_idx ON pokemons (name)',
  );
  late final Index pokemonDexIdx = Index(
    'pokemon_dex_idx',
    'CREATE INDEX pokemon_dex_idx ON pokemons (national_dex_number)',
  );
  late final Index pokemonGenerationIdx = Index(
    'pokemon_generation_idx',
    'CREATE INDEX pokemon_generation_idx ON pokemons (generation_id)',
  );
  late final Index pokemonStatTotalIdx = Index(
    'pokemon_stat_total_idx',
    'CREATE INDEX pokemon_stat_total_idx ON pokemons (base_stat_total)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pokemons,
    types,
    pokemonTypes,
    pokemonStats,
    favorites,
    syncMetadata,
    pokemonDetails,
    pokemonNameIdx,
    pokemonDexIdx,
    pokemonGenerationIdx,
    pokemonStatTotalIdx,
  ];
}

typedef $$PokemonsTableCreateCompanionBuilder = PokemonsCompanion Function({
  Value<int> id,
  required String name,
  required int nationalDexNumber,
  Value<String?> imageUrl,
  Value<String?> artworkUrl,
  Value<int?> generationId,
  Value<int> baseStatTotal,
  required DateTime updatedAt,
});
typedef $$PokemonsTableUpdateCompanionBuilder = PokemonsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> nationalDexNumber,
  Value<String?> imageUrl,
  Value<String?> artworkUrl,
  Value<int?> generationId,
  Value<int> baseStatTotal,
  Value<DateTime> updatedAt,
});

final class $$PokemonsTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonsTable, PokemonRow> {
  $$PokemonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonTypesTable, List<PokemonTypeRow>>
  _pokemonTypesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonTypes,
    aliasName: 'pokemons__id__pokemon_types__pokemon_id',
  );

  $$PokemonTypesTableProcessedTableManager get pokemonTypesRefs {
    final manager = $$PokemonTypesTableTableManager(
      $_db,
      $_db.pokemonTypes,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonTypesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PokemonStatsTable, List<PokemonStatRow>>
  _pokemonStatsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonStats,
    aliasName: 'pokemons__id__pokemon_stats__pokemon_id',
  );

  $$PokemonStatsTableProcessedTableManager get pokemonStatsRefs {
    final manager = $$PokemonStatsTableTableManager(
      $_db,
      $_db.pokemonStats,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonStatsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FavoritesTable, List<Favorite>>
  _favoritesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.favorites,
    aliasName: 'pokemons__id__favorites__pokemon_id',
  );

  $$FavoritesTableProcessedTableManager get favoritesRefs {
    final manager = $$FavoritesTableTableManager(
      $_db,
      $_db.favorites,
    ).filter((f) => f.pokemonId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_favoritesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PokemonsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonsTable> {
  $$PokemonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nationalDexNumber => $composableBuilder(
    column: $table.nationalDexNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseStatTotal => $composableBuilder(
    column: $table.baseStatTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonTypesRefs(
    Expression<bool> Function($$PokemonTypesTableFilterComposer f) f,
  ) {
    final $$PokemonTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypes,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pokemonStatsRefs(
    Expression<bool> Function($$PokemonStatsTableFilterComposer f) f,
  ) {
    final $$PokemonStatsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonStats,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonStatsTableFilterComposer(
            $db: $db,
            $table: $db.pokemonStats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> favoritesRefs(
    Expression<bool> Function($$FavoritesTableFilterComposer f) f,
  ) {
    final $$FavoritesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableFilterComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PokemonsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonsTable> {
  $$PokemonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nationalDexNumber => $composableBuilder(
    column: $table.nationalDexNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseStatTotal => $composableBuilder(
    column: $table.baseStatTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonsTable> {
  $$PokemonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get nationalDexNumber => $composableBuilder(
    column: $table.nationalDexNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get artworkUrl => $composableBuilder(
    column: $table.artworkUrl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get generationId => $composableBuilder(
    column: $table.generationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get baseStatTotal => $composableBuilder(
    column: $table.baseStatTotal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> pokemonTypesRefs<T extends Object>(
    Expression<T> Function($$PokemonTypesTableAnnotationComposer a) f,
  ) {
    final $$PokemonTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypes,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pokemonStatsRefs<T extends Object>(
    Expression<T> Function($$PokemonStatsTableAnnotationComposer a) f,
  ) {
    final $$PokemonStatsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonStats,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonStatsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonStats,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> favoritesRefs<T extends Object>(
    Expression<T> Function($$FavoritesTableAnnotationComposer a) f,
  ) {
    final $$FavoritesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.favorites,
      getReferencedColumn: (t) => t.pokemonId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavoritesTableAnnotationComposer(
            $db: $db,
            $table: $db.favorites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PokemonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonsTable,
          PokemonRow,
          $$PokemonsTableFilterComposer,
          $$PokemonsTableOrderingComposer,
          $$PokemonsTableAnnotationComposer,
          $$PokemonsTableCreateCompanionBuilder,
          $$PokemonsTableUpdateCompanionBuilder,
          (PokemonRow, $$PokemonsTableReferences),
          PokemonRow,
          PrefetchHooks Function({
            bool pokemonTypesRefs,
            bool pokemonStatsRefs,
            bool favoritesRefs,
          })
        > {
  $$PokemonsTableTableManager(_$AppDatabase db, $PokemonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> nationalDexNumber = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> artworkUrl = const Value.absent(),
                Value<int?> generationId = const Value.absent(),
                Value<int> baseStatTotal = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PokemonsCompanion(
                id: id,
                name: name,
                nationalDexNumber: nationalDexNumber,
                imageUrl: imageUrl,
                artworkUrl: artworkUrl,
                generationId: generationId,
                baseStatTotal: baseStatTotal,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int nationalDexNumber,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> artworkUrl = const Value.absent(),
                Value<int?> generationId = const Value.absent(),
                Value<int> baseStatTotal = const Value.absent(),
                required DateTime updatedAt,
              }) => PokemonsCompanion.insert(
                id: id,
                name: name,
                nationalDexNumber: nationalDexNumber,
                imageUrl: imageUrl,
                artworkUrl: artworkUrl,
                generationId: generationId,
                baseStatTotal: baseStatTotal,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonsTable, PokemonRow>(table),
                  $$PokemonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pokemonTypesRefs = false,
                pokemonStatsRefs = false,
                favoritesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pokemonTypesRefs) db.pokemonTypes,
                    if (pokemonStatsRefs) db.pokemonStats,
                    if (favoritesRefs) db.favorites,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pokemonTypesRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonsTable,
                          PokemonTypeRow,
                          $PokemonTypesTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._pokemonTypesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonTypesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (pokemonStatsRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonsTable,
                          PokemonStatRow,
                          $PokemonStatsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._pokemonStatsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).pokemonStatsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                      if (favoritesRefs)
                        await $_getPrefetchedDataByColumns<
                          PokemonRow,
                          $PokemonsTable,
                          Favorite,
                          $FavoritesTable
                        >(
                          currentTable: table,
                          referencedTable: $$PokemonsTableReferences
                              ._favoritesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PokemonsTableReferences(
                                db,
                                table,
                                p0,
                              ).favoritesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pokemon_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PokemonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonsTable,
      PokemonRow,
      $$PokemonsTableFilterComposer,
      $$PokemonsTableOrderingComposer,
      $$PokemonsTableAnnotationComposer,
      $$PokemonsTableCreateCompanionBuilder,
      $$PokemonsTableUpdateCompanionBuilder,
      (PokemonRow, $$PokemonsTableReferences),
      PokemonRow,
      PrefetchHooks Function({
        bool pokemonTypesRefs,
        bool pokemonStatsRefs,
        bool favoritesRefs,
      })
    >;
typedef $$TypesTableCreateCompanionBuilder = TypesCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$TypesTableUpdateCompanionBuilder = TypesCompanion Function({
  Value<int> id,
  Value<String> name,
});

final class $$TypesTableReferences
    extends BaseReferences<_$AppDatabase, $TypesTable, TypeRow> {
  $$TypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PokemonTypesTable, List<PokemonTypeRow>>
  _pokemonTypesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pokemonTypes,
    aliasName: 'types__id__pokemon_types__type_id',
  );

  $$PokemonTypesTableProcessedTableManager get pokemonTypesRefs {
    final manager = $$PokemonTypesTableTableManager(
      $_db,
      $_db.pokemonTypes,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pokemonTypesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TypesTableFilterComposer extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pokemonTypesRefs(
    Expression<bool> Function($$PokemonTypesTableFilterComposer f) f,
  ) {
    final $$PokemonTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypes,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableFilterComposer(
            $db: $db,
            $table: $db.pokemonTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypesTableOrderingComposer
    extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TypesTable> {
  $$TypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> pokemonTypesRefs<T extends Object>(
    Expression<T> Function($$PokemonTypesTableAnnotationComposer a) f,
  ) {
    final $$PokemonTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pokemonTypes,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemonTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TypesTable,
          TypeRow,
          $$TypesTableFilterComposer,
          $$TypesTableOrderingComposer,
          $$TypesTableAnnotationComposer,
          $$TypesTableCreateCompanionBuilder,
          $$TypesTableUpdateCompanionBuilder,
          (TypeRow, $$TypesTableReferences),
          TypeRow,
          PrefetchHooks Function({bool pokemonTypesRefs})
        > {
  $$TypesTableTableManager(_$AppDatabase db, $TypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) => TypesCompanion(id: id, name: name),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) => TypesCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TypesTable, TypeRow>(table),
                  $$TypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonTypesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (pokemonTypesRefs) db.pokemonTypes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pokemonTypesRefs)
                    await $_getPrefetchedDataByColumns<
                      TypeRow,
                      $TypesTable,
                      PokemonTypeRow,
                      $PokemonTypesTable
                    >(
                      currentTable: table,
                      referencedTable: $$TypesTableReferences
                          ._pokemonTypesRefsTable(db),
                      managerFromTypedResult: (p0) => $$TypesTableReferences(
                        db,
                        table,
                        p0,
                      ).pokemonTypesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'type_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TypesTable,
      TypeRow,
      $$TypesTableFilterComposer,
      $$TypesTableOrderingComposer,
      $$TypesTableAnnotationComposer,
      $$TypesTableCreateCompanionBuilder,
      $$TypesTableUpdateCompanionBuilder,
      (TypeRow, $$TypesTableReferences),
      TypeRow,
      PrefetchHooks Function({bool pokemonTypesRefs})
    >;
typedef $$PokemonTypesTableCreateCompanionBuilder =
    PokemonTypesCompanion Function({
      required int pokemonId,
      required int typeId,
      required int slot,
      Value<int> rowid,
    });
typedef $$PokemonTypesTableUpdateCompanionBuilder =
    PokemonTypesCompanion Function({
      Value<int> pokemonId,
      Value<int> typeId,
      Value<int> slot,
      Value<int> rowid,
    });

final class $$PokemonTypesTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonTypesTable, PokemonTypeRow> {
  $$PokemonTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_types__pokemon_id__pokemons__id');

  $$PokemonsTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TypesTable _typeIdTable(_$AppDatabase db) =>
      db.types.createAlias('pokemon_types__type_id__types__id');

  $$TypesTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<int>('type_id')!;

    final manager = $$TypesTableTableManager(
      $_db,
      $_db.types,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonTypesTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonsTableFilterComposer get pokemonId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableFilterComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableFilterComposer get typeId {
    final $$TypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableFilterComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonsTableOrderingComposer get pokemonId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableOrderingComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableOrderingComposer get typeId {
    final $$TypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableOrderingComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonTypesTable> {
  $$PokemonTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  $$PokemonsTableAnnotationComposer get pokemonId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TypesTableAnnotationComposer get typeId {
    final $$TypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.types,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TypesTableAnnotationComposer(
            $db: $db,
            $table: $db.types,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonTypesTable,
          PokemonTypeRow,
          $$PokemonTypesTableFilterComposer,
          $$PokemonTypesTableOrderingComposer,
          $$PokemonTypesTableAnnotationComposer,
          $$PokemonTypesTableCreateCompanionBuilder,
          $$PokemonTypesTableUpdateCompanionBuilder,
          (PokemonTypeRow, $$PokemonTypesTableReferences),
          PokemonTypeRow,
          PrefetchHooks Function({bool pokemonId, bool typeId})
        > {
  $$PokemonTypesTableTableManager(_$AppDatabase db, $PokemonTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<int> slot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonTypesCompanion(
                pokemonId: pokemonId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required int typeId,
                required int slot,
                Value<int> rowid = const Value.absent(),
              }) => PokemonTypesCompanion.insert(
                pokemonId: pokemonId,
                typeId: typeId,
                slot: slot,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonTypesTable, PokemonTypeRow>(table),
                  $$PokemonTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false, typeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonTypesTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonTypesTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (typeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.typeId,
                        referencedTable: $$PokemonTypesTableReferences
                            ._typeIdTable(db),
                        referencedColumn: $$PokemonTypesTableReferences
                            ._typeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PokemonTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonTypesTable,
      PokemonTypeRow,
      $$PokemonTypesTableFilterComposer,
      $$PokemonTypesTableOrderingComposer,
      $$PokemonTypesTableAnnotationComposer,
      $$PokemonTypesTableCreateCompanionBuilder,
      $$PokemonTypesTableUpdateCompanionBuilder,
      (PokemonTypeRow, $$PokemonTypesTableReferences),
      PokemonTypeRow,
      PrefetchHooks Function({bool pokemonId, bool typeId})
    >;
typedef $$PokemonStatsTableCreateCompanionBuilder =
    PokemonStatsCompanion Function({
      required int pokemonId,
      required String statName,
      required int baseStat,
      Value<int> rowid,
    });
typedef $$PokemonStatsTableUpdateCompanionBuilder =
    PokemonStatsCompanion Function({
      Value<int> pokemonId,
      Value<String> statName,
      Value<int> baseStat,
      Value<int> rowid,
    });

final class $$PokemonStatsTableReferences
    extends BaseReferences<_$AppDatabase, $PokemonStatsTable, PokemonStatRow> {
  $$PokemonStatsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('pokemon_stats__pokemon_id__pokemons__id');

  $$PokemonsTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PokemonStatsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonStatsTable> {
  $$PokemonStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get statName => $composableBuilder(
    column: $table.statName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseStat => $composableBuilder(
    column: $table.baseStat,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonsTableFilterComposer get pokemonId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableFilterComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonStatsTable> {
  $$PokemonStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get statName => $composableBuilder(
    column: $table.statName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseStat => $composableBuilder(
    column: $table.baseStat,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonsTableOrderingComposer get pokemonId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableOrderingComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonStatsTable> {
  $$PokemonStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get statName =>
      $composableBuilder(column: $table.statName, builder: (column) => column);

  GeneratedColumn<int> get baseStat =>
      $composableBuilder(column: $table.baseStat, builder: (column) => column);

  $$PokemonsTableAnnotationComposer get pokemonId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PokemonStatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonStatsTable,
          PokemonStatRow,
          $$PokemonStatsTableFilterComposer,
          $$PokemonStatsTableOrderingComposer,
          $$PokemonStatsTableAnnotationComposer,
          $$PokemonStatsTableCreateCompanionBuilder,
          $$PokemonStatsTableUpdateCompanionBuilder,
          (PokemonStatRow, $$PokemonStatsTableReferences),
          PokemonStatRow,
          PrefetchHooks Function({bool pokemonId})
        > {
  $$PokemonStatsTableTableManager(_$AppDatabase db, $PokemonStatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<String> statName = const Value.absent(),
                Value<int> baseStat = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PokemonStatsCompanion(
                pokemonId: pokemonId,
                statName: statName,
                baseStat: baseStat,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int pokemonId,
                required String statName,
                required int baseStat,
                Value<int> rowid = const Value.absent(),
              }) => PokemonStatsCompanion.insert(
                pokemonId: pokemonId,
                statName: statName,
                baseStat: baseStat,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonStatsTable, PokemonStatRow>(table),
                  $$PokemonStatsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$PokemonStatsTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$PokemonStatsTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PokemonStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonStatsTable,
      PokemonStatRow,
      $$PokemonStatsTableFilterComposer,
      $$PokemonStatsTableOrderingComposer,
      $$PokemonStatsTableAnnotationComposer,
      $$PokemonStatsTableCreateCompanionBuilder,
      $$PokemonStatsTableUpdateCompanionBuilder,
      (PokemonStatRow, $$PokemonStatsTableReferences),
      PokemonStatRow,
      PrefetchHooks Function({bool pokemonId})
    >;
typedef $$FavoritesTableCreateCompanionBuilder = FavoritesCompanion Function({
  Value<int> pokemonId,
  required DateTime createdAt,
});
typedef $$FavoritesTableUpdateCompanionBuilder = FavoritesCompanion Function({
  Value<int> pokemonId,
  Value<DateTime> createdAt,
});

final class $$FavoritesTableReferences
    extends BaseReferences<_$AppDatabase, $FavoritesTable, Favorite> {
  $$FavoritesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PokemonsTable _pokemonIdTable(_$AppDatabase db) =>
      db.pokemons.createAlias('favorites__pokemon_id__pokemons__id');

  $$PokemonsTableProcessedTableManager get pokemonId {
    final $_column = $_itemColumn<int>('pokemon_id')!;

    final manager = $$PokemonsTableTableManager(
      $_db,
      $_db.pokemons,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pokemonIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PokemonsTableFilterComposer get pokemonId {
    final $$PokemonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableFilterComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PokemonsTableOrderingComposer get pokemonId {
    final $$PokemonsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableOrderingComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PokemonsTableAnnotationComposer get pokemonId {
    final $$PokemonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pokemonId,
      referencedTable: $db.pokemons,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PokemonsTableAnnotationComposer(
            $db: $db,
            $table: $db.pokemons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTable,
          Favorite,
          $$FavoritesTableFilterComposer,
          $$FavoritesTableOrderingComposer,
          $$FavoritesTableAnnotationComposer,
          $$FavoritesTableCreateCompanionBuilder,
          $$FavoritesTableUpdateCompanionBuilder,
          (Favorite, $$FavoritesTableReferences),
          Favorite,
          PrefetchHooks Function({bool pokemonId})
        > {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> pokemonId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) => FavoritesCompanion(pokemonId: pokemonId, createdAt: createdAt),
          createCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                required DateTime createdAt,
              }) => FavoritesCompanion.insert(
                pokemonId: pokemonId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FavoritesTable, Favorite>(table),
                  $$FavoritesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pokemonId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pokemonId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pokemonId,
                        referencedTable: $$FavoritesTableReferences
                            ._pokemonIdTable(db),
                        referencedColumn: $$FavoritesTableReferences
                            ._pokemonIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTable,
      Favorite,
      $$FavoritesTableFilterComposer,
      $$FavoritesTableOrderingComposer,
      $$FavoritesTableAnnotationComposer,
      $$FavoritesTableCreateCompanionBuilder,
      $$FavoritesTableUpdateCompanionBuilder,
      (Favorite, $$FavoritesTableReferences),
      Favorite,
      PrefetchHooks Function({bool pokemonId})
    >;
typedef $$SyncMetadataTableCreateCompanionBuilder =
    SyncMetadataCompanion Function({
      required String resourceKey,
      Value<DateTime?> lastSuccessAt,
      required String status,
      Value<int> nextOffset,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableUpdateCompanionBuilder =
    SyncMetadataCompanion Function({
      Value<String> resourceKey,
      Value<DateTime?> lastSuccessAt,
      Value<String> status,
      Value<int> nextOffset,
      Value<int> rowid,
    });

class $$SyncMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextOffset => $composableBuilder(
    column: $table.nextOffset,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextOffset => $composableBuilder(
    column: $table.nextOffset,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get resourceKey => $composableBuilder(
    column: $table.resourceKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSuccessAt => $composableBuilder(
    column: $table.lastSuccessAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get nextOffset => $composableBuilder(
    column: $table.nextOffset,
    builder: (column) => column,
  );
}

class $$SyncMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetadataTable,
          SyncMetadataData,
          $$SyncMetadataTableFilterComposer,
          $$SyncMetadataTableOrderingComposer,
          $$SyncMetadataTableAnnotationComposer,
          $$SyncMetadataTableCreateCompanionBuilder,
          $$SyncMetadataTableUpdateCompanionBuilder,
          (
            SyncMetadataData,
            BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>,
          ),
          SyncMetadataData,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableManager(_$AppDatabase db, $SyncMetadataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> resourceKey = const Value.absent(),
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> nextOffset = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion(
                resourceKey: resourceKey,
                lastSuccessAt: lastSuccessAt,
                status: status,
                nextOffset: nextOffset,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String resourceKey,
                Value<DateTime?> lastSuccessAt = const Value.absent(),
                required String status,
                Value<int> nextOffset = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion.insert(
                resourceKey: resourceKey,
                lastSuccessAt: lastSuccessAt,
                status: status,
                nextOffset: nextOffset,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncMetadataTable, SyncMetadataData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SyncMetadataTable,
                    SyncMetadataData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetadataTable,
      SyncMetadataData,
      $$SyncMetadataTableFilterComposer,
      $$SyncMetadataTableOrderingComposer,
      $$SyncMetadataTableAnnotationComposer,
      $$SyncMetadataTableCreateCompanionBuilder,
      $$SyncMetadataTableUpdateCompanionBuilder,
      (
        SyncMetadataData,
        BaseReferences<_$AppDatabase, $SyncMetadataTable, SyncMetadataData>,
      ),
      SyncMetadataData,
      PrefetchHooks Function()
    >;
typedef $$PokemonDetailsTableCreateCompanionBuilder =
    PokemonDetailsCompanion Function({
      Value<int> pokemonId,
      required String nombre,
      required int altura,
      required int peso,
      Value<String?> sprite,
      Value<String?> artwork,
      Value<String?> spriteShiny,
      Value<String?> artworkShiny,
      required String tipos,
      required String estadisticas,
      required String habilidades,
      required String movimientos,
      required String gruposHuevo,
      required String formas,
      required String evoluciones,
      required DateTime actualizadoEn,
    });
typedef $$PokemonDetailsTableUpdateCompanionBuilder =
    PokemonDetailsCompanion Function({
      Value<int> pokemonId,
      Value<String> nombre,
      Value<int> altura,
      Value<int> peso,
      Value<String?> sprite,
      Value<String?> artwork,
      Value<String?> spriteShiny,
      Value<String?> artworkShiny,
      Value<String> tipos,
      Value<String> estadisticas,
      Value<String> habilidades,
      Value<String> movimientos,
      Value<String> gruposHuevo,
      Value<String> formas,
      Value<String> evoluciones,
      Value<DateTime> actualizadoEn,
    });

class $$PokemonDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $PokemonDetailsTable> {
  $$PokemonDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altura => $composableBuilder(
    column: $table.altura,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get peso => $composableBuilder(
    column: $table.peso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sprite => $composableBuilder(
    column: $table.sprite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artwork => $composableBuilder(
    column: $table.artwork,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spriteShiny => $composableBuilder(
    column: $table.spriteShiny,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artworkShiny => $composableBuilder(
    column: $table.artworkShiny,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipos => $composableBuilder(
    column: $table.tipos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estadisticas => $composableBuilder(
    column: $table.estadisticas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get habilidades => $composableBuilder(
    column: $table.habilidades,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get movimientos => $composableBuilder(
    column: $table.movimientos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gruposHuevo => $composableBuilder(
    column: $table.gruposHuevo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get formas => $composableBuilder(
    column: $table.formas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get evoluciones => $composableBuilder(
    column: $table.evoluciones,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PokemonDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $PokemonDetailsTable> {
  $$PokemonDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get pokemonId => $composableBuilder(
    column: $table.pokemonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altura => $composableBuilder(
    column: $table.altura,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get peso => $composableBuilder(
    column: $table.peso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sprite => $composableBuilder(
    column: $table.sprite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artwork => $composableBuilder(
    column: $table.artwork,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spriteShiny => $composableBuilder(
    column: $table.spriteShiny,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artworkShiny => $composableBuilder(
    column: $table.artworkShiny,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipos => $composableBuilder(
    column: $table.tipos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estadisticas => $composableBuilder(
    column: $table.estadisticas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get habilidades => $composableBuilder(
    column: $table.habilidades,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get movimientos => $composableBuilder(
    column: $table.movimientos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gruposHuevo => $composableBuilder(
    column: $table.gruposHuevo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formas => $composableBuilder(
    column: $table.formas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get evoluciones => $composableBuilder(
    column: $table.evoluciones,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PokemonDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PokemonDetailsTable> {
  $$PokemonDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<int> get altura =>
      $composableBuilder(column: $table.altura, builder: (column) => column);

  GeneratedColumn<int> get peso =>
      $composableBuilder(column: $table.peso, builder: (column) => column);

  GeneratedColumn<String> get sprite =>
      $composableBuilder(column: $table.sprite, builder: (column) => column);

  GeneratedColumn<String> get artwork =>
      $composableBuilder(column: $table.artwork, builder: (column) => column);

  GeneratedColumn<String> get spriteShiny => $composableBuilder(
    column: $table.spriteShiny,
    builder: (column) => column,
  );

  GeneratedColumn<String> get artworkShiny => $composableBuilder(
    column: $table.artworkShiny,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipos =>
      $composableBuilder(column: $table.tipos, builder: (column) => column);

  GeneratedColumn<String> get estadisticas => $composableBuilder(
    column: $table.estadisticas,
    builder: (column) => column,
  );

  GeneratedColumn<String> get habilidades => $composableBuilder(
    column: $table.habilidades,
    builder: (column) => column,
  );

  GeneratedColumn<String> get movimientos => $composableBuilder(
    column: $table.movimientos,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gruposHuevo => $composableBuilder(
    column: $table.gruposHuevo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get formas =>
      $composableBuilder(column: $table.formas, builder: (column) => column);

  GeneratedColumn<String> get evoluciones => $composableBuilder(
    column: $table.evoluciones,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => column,
  );
}

class $$PokemonDetailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PokemonDetailsTable,
          PokemonDetailRow,
          $$PokemonDetailsTableFilterComposer,
          $$PokemonDetailsTableOrderingComposer,
          $$PokemonDetailsTableAnnotationComposer,
          $$PokemonDetailsTableCreateCompanionBuilder,
          $$PokemonDetailsTableUpdateCompanionBuilder,
          (
            PokemonDetailRow,
            BaseReferences<
              _$AppDatabase,
              $PokemonDetailsTable,
              PokemonDetailRow
            >,
          ),
          PokemonDetailRow,
          PrefetchHooks Function()
        > {
  $$PokemonDetailsTableTableManager(
    _$AppDatabase db,
    $PokemonDetailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PokemonDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PokemonDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PokemonDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> altura = const Value.absent(),
                Value<int> peso = const Value.absent(),
                Value<String?> sprite = const Value.absent(),
                Value<String?> artwork = const Value.absent(),
                Value<String?> spriteShiny = const Value.absent(),
                Value<String?> artworkShiny = const Value.absent(),
                Value<String> tipos = const Value.absent(),
                Value<String> estadisticas = const Value.absent(),
                Value<String> habilidades = const Value.absent(),
                Value<String> movimientos = const Value.absent(),
                Value<String> gruposHuevo = const Value.absent(),
                Value<String> formas = const Value.absent(),
                Value<String> evoluciones = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
              }) => PokemonDetailsCompanion(
                pokemonId: pokemonId,
                nombre: nombre,
                altura: altura,
                peso: peso,
                sprite: sprite,
                artwork: artwork,
                spriteShiny: spriteShiny,
                artworkShiny: artworkShiny,
                tipos: tipos,
                estadisticas: estadisticas,
                habilidades: habilidades,
                movimientos: movimientos,
                gruposHuevo: gruposHuevo,
                formas: formas,
                evoluciones: evoluciones,
                actualizadoEn: actualizadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> pokemonId = const Value.absent(),
                required String nombre,
                required int altura,
                required int peso,
                Value<String?> sprite = const Value.absent(),
                Value<String?> artwork = const Value.absent(),
                Value<String?> spriteShiny = const Value.absent(),
                Value<String?> artworkShiny = const Value.absent(),
                required String tipos,
                required String estadisticas,
                required String habilidades,
                required String movimientos,
                required String gruposHuevo,
                required String formas,
                required String evoluciones,
                required DateTime actualizadoEn,
              }) => PokemonDetailsCompanion.insert(
                pokemonId: pokemonId,
                nombre: nombre,
                altura: altura,
                peso: peso,
                sprite: sprite,
                artwork: artwork,
                spriteShiny: spriteShiny,
                artworkShiny: artworkShiny,
                tipos: tipos,
                estadisticas: estadisticas,
                habilidades: habilidades,
                movimientos: movimientos,
                gruposHuevo: gruposHuevo,
                formas: formas,
                evoluciones: evoluciones,
                actualizadoEn: actualizadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PokemonDetailsTable, PokemonDetailRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PokemonDetailsTable,
                    PokemonDetailRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PokemonDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PokemonDetailsTable,
      PokemonDetailRow,
      $$PokemonDetailsTableFilterComposer,
      $$PokemonDetailsTableOrderingComposer,
      $$PokemonDetailsTableAnnotationComposer,
      $$PokemonDetailsTableCreateCompanionBuilder,
      $$PokemonDetailsTableUpdateCompanionBuilder,
      (
        PokemonDetailRow,
        BaseReferences<_$AppDatabase, $PokemonDetailsTable, PokemonDetailRow>,
      ),
      PokemonDetailRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PokemonsTableTableManager get pokemons =>
      $$PokemonsTableTableManager(_db, _db.pokemons);
  $$TypesTableTableManager get types =>
      $$TypesTableTableManager(_db, _db.types);
  $$PokemonTypesTableTableManager get pokemonTypes =>
      $$PokemonTypesTableTableManager(_db, _db.pokemonTypes);
  $$PokemonStatsTableTableManager get pokemonStats =>
      $$PokemonStatsTableTableManager(_db, _db.pokemonStats);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
  $$SyncMetadataTableTableManager get syncMetadata =>
      $$SyncMetadataTableTableManager(_db, _db.syncMetadata);
  $$PokemonDetailsTableTableManager get pokemonDetails =>
      $$PokemonDetailsTableTableManager(_db, _db.pokemonDetails);
}
