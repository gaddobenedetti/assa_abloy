// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LockConfig _$LockConfigFromJson(Map<String, dynamic> json) => LockConfig(
      lockVoltage: json['lockVoltage'] == null
          ? null
          : Config.fromJson(json['lockVoltage'] as Map<String, dynamic>),
      lockType: json['lockType'] == null
          ? null
          : Config.fromJson(json['lockType'] as Map<String, dynamic>),
      lockKick: json['lockKick'] == null
          ? null
          : Config.fromJson(json['lockKick'] as Map<String, dynamic>),
      lockRelease: json['lockRelease'] == null
          ? null
          : Config.fromJson(json['lockRelease'] as Map<String, dynamic>),
      lockReleaseTime: json['lockReleaseTime'] == null
          ? null
          : Config.fromJson(json['lockReleaseTime'] as Map<String, dynamic>),
      lockAngle: json['lockAngle'] == null
          ? null
          : Config.fromJson(json['lockAngle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LockConfigToJson(LockConfig instance) =>
    <String, dynamic>{
      'lockVoltage': instance.lockVoltage,
      'lockType': instance.lockType,
      'lockKick': instance.lockKick,
      'lockRelease': instance.lockRelease,
      'lockReleaseTime': instance.lockReleaseTime,
      'lockAngle': instance.lockAngle,
    };

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      values: json['values'] as List<dynamic>?,
      defaultValue: json['default'],
      common: json['common'] as bool?,
      range: json['range'] == null
          ? null
          : Range.fromJson(json['range'] as Map<String, dynamic>),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'values': instance.values,
      'default': instance.defaultValue,
      'common': instance.common,
      'range': instance.range,
      'unit': instance.unit,
    };

Range _$RangeFromJson(Map<String, dynamic> json) => Range(
      min: json['min'],
      max: json['max'],
    );

Map<String, dynamic> _$RangeToJson(Range instance) => <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

LockStore _$LockStoreFromJson(Map<String, dynamic> json) => LockStore(
      lockVoltage: json['lockVoltage'],
      lockType: json['lockType'],
      lockKick: json['lockKick'],
      lockRelease: json['lockRelease'],
      lockReleaseTime: json['lockReleaseTime'],
      lockAngle: json['lockAngle'],
    );

Map<String, dynamic> _$LockStoreToJson(LockStore instance) => <String, dynamic>{
      'lockVoltage': instance.lockVoltage,
      'lockType': instance.lockType,
      'lockKick': instance.lockKick,
      'lockRelease': instance.lockRelease,
      'lockReleaseTime': instance.lockReleaseTime,
      'lockAngle': instance.lockAngle,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://run.mocky.io/v3/d5f5d613-474b-49c4-a7b0-7730e8f8f486';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LockConfig> getConfigs() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LockConfig>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = LockConfig.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
