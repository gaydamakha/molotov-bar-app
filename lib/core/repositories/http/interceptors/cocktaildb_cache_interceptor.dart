import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor/src/model/cache_strategy.dart';

class CocktaildbCacheInterceptor extends DioCacheInterceptor {
  CocktaildbCacheInterceptor({required CacheOptions options})
      : super(options: options) {
    assert(options.store != null);
    _options = options;
    _store = options.store!;
  }

  static const String _getMethodName = 'GET';
  static const String _postMethodName = 'POST';

  late final CacheOptions _options;
  late final CacheStore _store;

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.requestOptions.path.contains('search.php')) {
      var drinks = response.data['drinks'] as List<dynamic>;
      if (drinks == []) {
        return;
      }
      for (var element in drinks) {
        var drink = element as Map<String, dynamic>;
        var id = drink['idDrink'];
        final modifiedResponse = Response(
          requestOptions: response.requestOptions.copyWith(
            path: response.requestOptions.path
                .replaceFirst(RegExp(r'search\.php.*'), "lookup.php?i=$id"),
          ),
          data: jsonEncode({
            'drinks': [drink]
          }),
          headers: response.headers,
          isRedirect: response.isRedirect,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
          redirects: response.redirects,
          extra: response.extra,
        );
        _storeModified(modifiedResponse);
      }
    }
    super.onResponse(response, handler);
  }

  _storeModified(Response response) async {
    final cacheOptions = _getCacheOptions(response.requestOptions);

    if (_shouldSkip(response.requestOptions, options: cacheOptions)) {
      return;
    }

    if (cacheOptions.policy == CachePolicy.noCache) {
      // Delete previous potential cached response
      await _getCacheStore(cacheOptions).delete(
        cacheOptions.keyBuilder(response.requestOptions),
      );
    }

    await _saveResponse(
      response,
      cacheOptions,
      statusCode: response.statusCode,
    );
  }

  /// Gets cache options from given [request]
  /// or defaults to interceptor options.
  CacheOptions _getCacheOptions(RequestOptions request) {
    return CacheOptions.fromExtra(request) ?? _options;
  }

  /// Gets cache store from given [options]
  /// or defaults to interceptor store.
  CacheStore _getCacheStore(CacheOptions options) {
    return options.store ?? _store;
  }

  /// Check if the callback should not be proceed against HTTP method
  /// or cancel error type.
  bool _shouldSkip(
    RequestOptions? request, {
    required CacheOptions options,
    DioError? error,
  }) {
    if (error?.type == DioErrorType.cancel) {
      return true;
    }

    final rqMethod = request?.method.toUpperCase();
    var result = (rqMethod != _getMethodName);
    result &= (!options.allowPostMethod || rqMethod != _postMethodName);

    return result;
  }

  /// Writes cached response to cache store if strategy allows it.
  Future<void> _saveResponse(
    Response response,
    CacheOptions cacheOptions, {
    int? statusCode,
  }) async {
    final strategy = await CacheStrategyFactory(
      request: response.requestOptions,
      response: response,
      cacheOptions: cacheOptions,
    ).compute();

    final cacheResp = strategy.cacheResponse;
    if (cacheResp != null) {
      // Store response to cache store
      await _getCacheStore(cacheOptions).set(cacheResp);

      // Update extra fields with cache info
      response.extra[CacheResponse.cacheKey] = cacheResp.key;
      response.extra[CacheResponse.fromNetwork] =
          CacheStrategyFactory.allowedStatusCodes.contains(statusCode);
    }
  }
}
