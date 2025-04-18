import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class ServiceRequestCall {
  static Future<ApiCallResponse> call({
    String? patientName = 'hello',
  }) async {
    final ffApiRequestBody = '''
{
"patient_name":"${escapeStringForJson(patientName)}" 
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'serviceRequest',
      apiUrl: 'https://aidboxdev.shoprideon.com/fhir/ServiceRequest',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LogOutCall {
  static Future<ApiCallResponse> call({
    String? refreshToken = '',
  }) async {
    final ffApiRequestBody = '''
{
"refresh_token":"${escapeStringForJson(refreshToken)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'LogOut',
      apiUrl: 'https://flaskrideondev.shoprideon.com/auth/revoke',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LoginCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "${escapeStringForJson(username)}",
  "password": "${escapeStringForJson(password)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Login',
      apiUrl: 'https://flaskrideondev.shoprideon.com/auth/login',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? accessToken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.access_token''',
      ));
  static String? errorMessage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.Error''',
      ));
  static String? refreshToken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.refresh_token''',
      ));
}

class GetUserInfoCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetUserInfo',
      apiUrl: 'https://flaskrideondev.shoprideon.com/userinfo',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? aidboxId(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.aidbox_id''',
      ));
}

class GetUserDetailsCall {
  static Future<ApiCallResponse> call({
    String? aidboxId = '',
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetUserDetails',
      apiUrl: 'https://aidboxdev.shoprideon.com/fhir/User',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {
        '_id': aidboxId,
        '_revinclude': "Role:user:User",
        '_include': "User:organization:Organization",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetServiceRequestsCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
    String? patientId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetServiceRequests',
      apiUrl: 'https://aidboxdev.shoprideon.com/fhir/ServiceRequest',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: patientId != null && patientId.isNotEmpty
        ? {'subject': 'Patient/${patientId}'}
        : {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<dynamic>? entries(dynamic response) =>
      getJsonField(
        response,
        r'''$.entry''',
        true,
      ) as List<dynamic>?;

  static dynamic patientReference(dynamic entry) =>
      getJsonField(
        entry,
        r'''$.resource.subject.reference''',
      );

  static dynamic patientName(dynamic entry) =>
      getJsonField(
        entry,
        r'''$.resource.subject.display''',
      );

  static dynamic bloodPressure(dynamic entry) =>
      getJsonField(
        entry,
        r'''$.resource.extension[?(@.url == "blood-pressure")].valueString''',
        true,
      )?[0];

  static dynamic height(dynamic entry) =>
      getJsonField(
        entry,
        r'''$.resource.extension[?(@.url == "height")].valueString''',
        true,
      )?[0];

  static dynamic weight(dynamic entry) =>
      getJsonField(
        entry,
        r'''$.resource.extension[?(@.url == "weight")].valueString''',
        true,
      )?[0];

  static dynamic insuranceProvider(dynamic entry) =>
      getJsonField(
        entry,
        r'''$.resource.extension[?(@.url == "insurance-provider")].valueString''',
        true,
      )?[0];

  static dynamic policyNumber(dynamic entry) =>
      getJsonField(
        entry,
        r'''$.resource.extension[?(@.url == "policy-number")].valueString''',
        true,
      )?[0];
}

class GetPatientDetailsCall {
  static Future<ApiCallResponse> call({
    String? patientId = '',
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetPatientDetails',
      apiUrl: 'https://aidboxdev.shoprideon.com/fhir/Patient/${patientId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? patientName(dynamic response) {
    final given = getJsonField(
      response,
      r'''$.name[0].given''',
      true,
    ) as List<dynamic>?;
    
    final family = getJsonField(
      response,
      r'''$.name[0].family''',
    );
    
    if (given != null && given.isNotEmpty) {
      return '${given.join(' ')} ${family ?? ''}';
    }
    return null;
  }

  static String? birthDate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.birthDate''',
      ));

  static String? gender(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.gender''',
      ));

  static String? address(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.address[0].text''',
      ));
}

// Add this new API call to fetch task list data
class GetTaskListCall {
  static Future<ApiCallResponse> call({
    String? bearerToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetTaskList',
      apiUrl: 'https://aidboxdev.shoprideon.com/fhir/Task',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${bearerToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<dynamic>? entries(dynamic response) =>
      getJsonField(
        response,
        r'''$.entry''',
        true,
      ) as List<dynamic>?;

  static String? referralInitiator(dynamic entry) =>
      castToType<String>(getJsonField(
        entry,
        r'''$.resource.requester.display''',
      ));

  static String? referralRecipient(dynamic entry) =>
      castToType<String>(getJsonField(
        entry,
        r'''$.resource.owner.display''',
      ));

  static String? createdDate(dynamic entry) {
    final dateString = castToType<String>(getJsonField(
      entry,
      r'''$.resource.authoredOn''',
    ));
    if (dateString != null) {
      try {
        final date = DateTime.parse(dateString);
        return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      } catch (e) {
        return dateString;
      }
    }
    return null;
  }

  static String? updatedDate(dynamic entry) {
    final dateString = castToType<String>(getJsonField(
      entry,
      r'''$.resource.lastModified''',
    ));
    if (dateString != null) {
      try {
        final date = DateTime.parse(dateString);
        return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      } catch (e) {
        return dateString;
      }
    }
    return null;
  }

  static String? status(dynamic entry) =>
      castToType<String>(getJsonField(
        entry,
        r'''$.resource.status''',
      ));

  static String? id(dynamic entry) =>
      castToType<String>(getJsonField(
        entry,
        r'''$.resource.id''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
