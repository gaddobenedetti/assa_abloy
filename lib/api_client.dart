import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(
    baseUrl: 'https://run.mocky.io/v3/d5f5d613-474b-49c4-a7b0-7730e8f8f486')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/')
  Future<LockConfig> getConfigs();
}

@JsonSerializable()
class LockConfig {
  Config? lockVoltage;
  Config? lockType;
  Config? lockKick;
  Config? lockRelease;
  Config? lockReleaseTime;
  Config? lockAngle;

  LockConfig(
      {this.lockVoltage,
      this.lockType,
      this.lockKick,
      this.lockRelease,
      this.lockReleaseTime,
      this.lockAngle});

  factory LockConfig.fromJson(Map<String, dynamic> json) =>
      _$LockConfigFromJson(json);

  Map<String, dynamic> toJson() => _$LockConfigToJson(this);
}

@JsonSerializable()
class Config {
  List<dynamic>? values;
  @JsonKey(name: 'default')
  dynamic defaultValue;
  bool? common;
  Range? range;
  String? unit;

  final totalDoors = 2;

  Config({this.values, this.defaultValue, this.common, this.range, this.unit});

  dynamic validateInput(dynamic value) {
    if (values != null) {
      if (!values!.contains(value)) {
        value = defaultValue;
      }
    } else if (range != null) {
      if (value == null || value > range!.max || value < range!.min) {
        value = defaultValue;
      }
    }
    return value;
  }

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}

@JsonSerializable()
class Range {
  dynamic min;
  dynamic max;

  Range({this.min, this.max});

  factory Range.fromJson(Map<String, dynamic> json) => _$RangeFromJson(json);

  Map<String, dynamic> toJson() => _$RangeToJson(this);
}

@JsonSerializable()
class LockStore {
  dynamic lockVoltage;
  dynamic lockType;
  dynamic lockKick;
  dynamic lockRelease;
  dynamic lockReleaseTime;
  dynamic lockAngle;

  LockStore(
      {this.lockVoltage,
      this.lockType,
      this.lockKick,
      this.lockRelease,
      this.lockReleaseTime,
      this.lockAngle});

  factory LockStore.fromJson(Map<String, dynamic> json) =>
      _$LockStoreFromJson(json);

  Map<String, dynamic> toJson() => _$LockStoreToJson(this);
}

class Repo {
  late final RestClient client;

  Repo() {
    final dio = Dio();
    dio.options.headers['X-Header'] = 'X-header';
    client = RestClient(dio);
  }

  Future<LockConfig> getLockConfigs() async {
    return await client.getConfigs();
  }
}
