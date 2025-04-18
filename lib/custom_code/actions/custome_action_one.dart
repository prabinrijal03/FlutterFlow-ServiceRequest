// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:dio/dio.dart';
import 'package:fhir/r4.dart';

Future customeActionOne(
    String bearerToken,
    String patientName,
    String dob,
    String age,
    String gender,
    String bloodPressure,
    String height,
    String weight,
    String insuranceProvider,
    String policyNumber,
    String patientAddress) async {
  final dio = Dio();
  final baseUrl =
      'https://aidboxdev.shoprideon.com/fhir'; // Update with your Aidbox base Url

  String? patientId;

  // Safely split the patient name
  List<String> nameParts = patientName.split(' ');
  String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
  String lastName = nameParts.length > 1 ? nameParts[1] : '';

  // Create patient with proper error handling
  final patient = Patient(
    name: [
      HumanName(
        family: lastName,
        given: [firstName],
      ),
    ],
    birthDate: FhirDate(DateTime.parse(dob)),
    gender: FhirCode(gender.toLowerCase()),
    address: patientAddress.isNotEmpty
        ? [
            Address(
              text: patientAddress,
            ),
          ]
        : null,
  );

  try {
    Response patientResponse = await dio.post(
      '$baseUrl/Patient',
      data: patient.toJson(),
      options: Options(headers: {
        'Content-Type': 'application/fhir+json',
        'Authorization': 'Bearer $bearerToken',
      }),
    );
    print('Patient created successfully: ${patientResponse.data}');
    patientId = patientResponse.data['id'];

    if (patientId == null) {
      throw Exception('Patient ID not found in response.');
    }

    // Create service request with required fields
    final serviceRequest = ServiceRequest(
      resourceType: R4ResourceType.ServiceRequest,
      status: FhirCode('draft'), // Required field
      intent: FhirCode('order'), // Required field
      subject: Reference(
        type: FhirUri('Patient'),
        reference: 'Patient/$patientId', // Use the actual patient ID
      ),
      extension_: <FhirExtension>[
        FhirExtension(
          url: FhirUri('blood-pressure'),
          valueString: bloodPressure,
        ),
        FhirExtension(
          url: FhirUri('height'),
          valueString: height,
        ),
        FhirExtension(
          url: FhirUri('weight'),
          valueString: weight,
        ),
        FhirExtension(
          url: FhirUri('insurance-provider'),
          valueString: insuranceProvider,
        ),
        FhirExtension(
          url: FhirUri('policy-number'),
          valueString: policyNumber,
        ),
      ],
    );

    final serviceResponse = await dio.post(
      '$baseUrl/ServiceRequest',
      data: serviceRequest.toJson(),
      options: Options(headers: {
        'Content-Type': 'application/fhir+json',
        'Authorization': 'Bearer $bearerToken',
      }),
    );
    print('ServiceRequest sent successfully: ${serviceResponse.data}');
    return serviceResponse.data['id']; // Return the service request ID
  } catch (e) {
    print('Error in FHIR operation: $e');
    if (e is DioException) {
      print('Response data: ${e.response?.data}');
      print('Response status: ${e.response?.statusCode}');
    }
    throw Exception('Failed to complete FHIR operation: $e');
  }
}
