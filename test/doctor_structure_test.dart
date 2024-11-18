import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> createDoctorData(String name, String expertise,
    String address, double? rating, double? latitude, double? longitude) {
  return {
    'name': name,
    'expertise': expertise,
    'address': address,
    'rating': rating,
    if (latitude != null && longitude != null)
      'location': {
        'latitude': latitude,
        'longitude': longitude,
      }
  };
}

void main() {
  test('Doctor data structure is created correctly', () {
    final doctorData = createDoctorData(
        'Dr. Smith', 'Cardiology', '123 Main St', 4.5, 12.34, 56.78);

    expect(doctorData['name'], 'Dr. Smith');
    expect(doctorData['expertise'], 'Cardiology');
    expect(doctorData['address'], '123 Main St');
    expect(doctorData['rating'], 4.5);
    expect(doctorData['location']['latitude'], 12.34);
    expect(doctorData['location']['longitude'], 56.78);
  });
}
