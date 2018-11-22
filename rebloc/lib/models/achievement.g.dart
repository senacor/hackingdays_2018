// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializer<Achievement> _$achievementSerializer = new _$AchievementSerializer();

class _$AchievementSerializer implements StructuredSerializer<Achievement> {
  @override
  final Iterable<Type> types = const [Achievement, _$Achievement];
  @override
  final String wireName = 'Achievement';

  @override
  Iterable serialize(Serializers serializers, Achievement object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'achievementTypeId',
      serializers.serialize(object.achievementTypeId,
          specifiedType: const FullType(String)),
      'gained',
      serializers.serialize(object.gained, specifiedType: const FullType(bool)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'header',
      serializers.serialize(object.header,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'imageUrl',
      serializers.serialize(object.imageUrl,
          specifiedType: const FullType(String)),
      'previewImageUrl',
      serializers.serialize(object.previewImageUrl,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Achievement deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AchievementBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'achievementTypeId':
          result.achievementTypeId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'gained':
          result.gained = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'header':
          result.header = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'previewImageUrl':
          result.previewImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Achievement extends Achievement {
  @override
  final String id;
  @override
  final String achievementTypeId;
  @override
  final bool gained;
  @override
  final String title;
  @override
  final String header;
  @override
  final String description;
  @override
  final String imageUrl;
  @override
  final String previewImageUrl;

  factory _$Achievement([void updates(AchievementBuilder b)]) =>
      (new AchievementBuilder()..update(updates)).build();

  _$Achievement._(
      {this.id,
      this.achievementTypeId,
      this.gained,
      this.title,
      this.header,
      this.description,
      this.imageUrl,
      this.previewImageUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Achievement', 'id');
    }
    if (achievementTypeId == null) {
      throw new BuiltValueNullFieldError('Achievement', 'achievementTypeId');
    }
    if (gained == null) {
      throw new BuiltValueNullFieldError('Achievement', 'gained');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Achievement', 'title');
    }
    if (header == null) {
      throw new BuiltValueNullFieldError('Achievement', 'header');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('Achievement', 'description');
    }
    if (imageUrl == null) {
      throw new BuiltValueNullFieldError('Achievement', 'imageUrl');
    }
    if (previewImageUrl == null) {
      throw new BuiltValueNullFieldError('Achievement', 'previewImageUrl');
    }
  }

  @override
  Achievement rebuild(void updates(AchievementBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AchievementBuilder toBuilder() => new AchievementBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Achievement &&
        id == other.id &&
        achievementTypeId == other.achievementTypeId &&
        gained == other.gained &&
        title == other.title &&
        header == other.header &&
        description == other.description &&
        imageUrl == other.imageUrl &&
        previewImageUrl == other.previewImageUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, id.hashCode),
                                achievementTypeId.hashCode),
                            gained.hashCode),
                        title.hashCode),
                    header.hashCode),
                description.hashCode),
            imageUrl.hashCode),
        previewImageUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Achievement')
          ..add('id', id)
          ..add('achievementTypeId', achievementTypeId)
          ..add('gained', gained)
          ..add('title', title)
          ..add('header', header)
          ..add('description', description)
          ..add('imageUrl', imageUrl)
          ..add('previewImageUrl', previewImageUrl))
        .toString();
  }
}

class AchievementBuilder implements Builder<Achievement, AchievementBuilder> {
  _$Achievement _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _achievementTypeId;
  String get achievementTypeId => _$this._achievementTypeId;
  set achievementTypeId(String achievementTypeId) =>
      _$this._achievementTypeId = achievementTypeId;

  bool _gained;
  bool get gained => _$this._gained;
  set gained(bool gained) => _$this._gained = gained;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _header;
  String get header => _$this._header;
  set header(String header) => _$this._header = header;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  String _previewImageUrl;
  String get previewImageUrl => _$this._previewImageUrl;
  set previewImageUrl(String previewImageUrl) =>
      _$this._previewImageUrl = previewImageUrl;

  AchievementBuilder();

  AchievementBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _achievementTypeId = _$v.achievementTypeId;
      _gained = _$v.gained;
      _title = _$v.title;
      _header = _$v.header;
      _description = _$v.description;
      _imageUrl = _$v.imageUrl;
      _previewImageUrl = _$v.previewImageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Achievement other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Achievement;
  }

  @override
  void update(void updates(AchievementBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Achievement build() {
    final _$result = _$v ??
        new _$Achievement._(
            id: id,
            achievementTypeId: achievementTypeId,
            gained: gained,
            title: title,
            header: header,
            description: description,
            imageUrl: imageUrl,
            previewImageUrl: previewImageUrl);
    replace(_$result);
    return _$result;
  }
}
