// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentModel _$AgentModelFromJson(Map<String, dynamic> json) {
  return _AgentModel.fromJson(json);
}

/// @nodoc
mixin _$AgentModel {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  Map<int, int> get rating => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  List<String> get category => throw _privateConstructorUsedError;
  int get conversationCount => throw _privateConstructorUsedError;
  List<String> get conversationStarters => throw _privateConstructorUsedError;
  List<String> get skills => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentModelCopyWith<AgentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentModelCopyWith<$Res> {
  factory $AgentModelCopyWith(
          AgentModel value, $Res Function(AgentModel) then) =
      _$AgentModelCopyWithImpl<$Res, AgentModel>;
  @useResult
  $Res call(
      {String uid,
      String name,
      String description,
      String imageUrl,
      Map<int, int> rating,
      String createdBy,
      List<String> category,
      int conversationCount,
      List<String> conversationStarters,
      List<String> skills,
      DateTime createdAt});
}

/// @nodoc
class _$AgentModelCopyWithImpl<$Res, $Val extends AgentModel>
    implements $AgentModelCopyWith<$Res> {
  _$AgentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? rating = null,
    Object? createdBy = null,
    Object? category = null,
    Object? conversationCount = null,
    Object? conversationStarters = null,
    Object? skills = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as List<String>,
      conversationCount: null == conversationCount
          ? _value.conversationCount
          : conversationCount // ignore: cast_nullable_to_non_nullable
              as int,
      conversationStarters: null == conversationStarters
          ? _value.conversationStarters
          : conversationStarters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      skills: null == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentModelImplCopyWith<$Res>
    implements $AgentModelCopyWith<$Res> {
  factory _$$AgentModelImplCopyWith(
          _$AgentModelImpl value, $Res Function(_$AgentModelImpl) then) =
      __$$AgentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String description,
      String imageUrl,
      Map<int, int> rating,
      String createdBy,
      List<String> category,
      int conversationCount,
      List<String> conversationStarters,
      List<String> skills,
      DateTime createdAt});
}

/// @nodoc
class __$$AgentModelImplCopyWithImpl<$Res>
    extends _$AgentModelCopyWithImpl<$Res, _$AgentModelImpl>
    implements _$$AgentModelImplCopyWith<$Res> {
  __$$AgentModelImplCopyWithImpl(
      _$AgentModelImpl _value, $Res Function(_$AgentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? rating = null,
    Object? createdBy = null,
    Object? category = null,
    Object? conversationCount = null,
    Object? conversationStarters = null,
    Object? skills = null,
    Object? createdAt = null,
  }) {
    return _then(_$AgentModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value._rating
          : rating // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value._category
          : category // ignore: cast_nullable_to_non_nullable
              as List<String>,
      conversationCount: null == conversationCount
          ? _value.conversationCount
          : conversationCount // ignore: cast_nullable_to_non_nullable
              as int,
      conversationStarters: null == conversationStarters
          ? _value._conversationStarters
          : conversationStarters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      skills: null == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentModelImpl with DiagnosticableTreeMixin implements _AgentModel {
  const _$AgentModelImpl(
      {required this.uid,
      required this.name,
      required this.description,
      required this.imageUrl,
      required final Map<int, int> rating,
      required this.createdBy,
      required final List<String> category,
      required this.conversationCount,
      required final List<String> conversationStarters,
      required final List<String> skills,
      required this.createdAt})
      : _rating = rating,
        _category = category,
        _conversationStarters = conversationStarters,
        _skills = skills;

  factory _$AgentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentModelImplFromJson(json);

  @override
  final String uid;
  @override
  final String name;
  @override
  final String description;
  @override
  final String imageUrl;
  final Map<int, int> _rating;
  @override
  Map<int, int> get rating {
    if (_rating is EqualUnmodifiableMapView) return _rating;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_rating);
  }

  @override
  final String createdBy;
  final List<String> _category;
  @override
  List<String> get category {
    if (_category is EqualUnmodifiableListView) return _category;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_category);
  }

  @override
  final int conversationCount;
  final List<String> _conversationStarters;
  @override
  List<String> get conversationStarters {
    if (_conversationStarters is EqualUnmodifiableListView)
      return _conversationStarters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversationStarters);
  }

  final List<String> _skills;
  @override
  List<String> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  @override
  final DateTime createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AgentModel(uid: $uid, name: $name, description: $description, imageUrl: $imageUrl, rating: $rating, createdBy: $createdBy, category: $category, conversationCount: $conversationCount, conversationStarters: $conversationStarters, skills: $skills, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AgentModel'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('createdBy', createdBy))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('conversationCount', conversationCount))
      ..add(DiagnosticsProperty('conversationStarters', conversationStarters))
      ..add(DiagnosticsProperty('skills', skills))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgentModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._rating, _rating) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            const DeepCollectionEquality().equals(other._category, _category) &&
            (identical(other.conversationCount, conversationCount) ||
                other.conversationCount == conversationCount) &&
            const DeepCollectionEquality()
                .equals(other._conversationStarters, _conversationStarters) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      name,
      description,
      imageUrl,
      const DeepCollectionEquality().hash(_rating),
      createdBy,
      const DeepCollectionEquality().hash(_category),
      conversationCount,
      const DeepCollectionEquality().hash(_conversationStarters),
      const DeepCollectionEquality().hash(_skills),
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentModelImplCopyWith<_$AgentModelImpl> get copyWith =>
      __$$AgentModelImplCopyWithImpl<_$AgentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentModelImplToJson(
      this,
    );
  }
}

abstract class _AgentModel implements AgentModel {
  const factory _AgentModel(
      {required final String uid,
      required final String name,
      required final String description,
      required final String imageUrl,
      required final Map<int, int> rating,
      required final String createdBy,
      required final List<String> category,
      required final int conversationCount,
      required final List<String> conversationStarters,
      required final List<String> skills,
      required final DateTime createdAt}) = _$AgentModelImpl;

  factory _AgentModel.fromJson(Map<String, dynamic> json) =
      _$AgentModelImpl.fromJson;

  @override
  String get uid;
  @override
  String get name;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  Map<int, int> get rating;
  @override
  String get createdBy;
  @override
  List<String> get category;
  @override
  int get conversationCount;
  @override
  List<String> get conversationStarters;
  @override
  List<String> get skills;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$AgentModelImplCopyWith<_$AgentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
