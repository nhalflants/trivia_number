import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_app/core/network/data_connection_checker.dart';
import 'package:trivia_app/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([DataConnectionChecker])
void main() {
  MockDataConnectionChecker mockDataConnectionChecker =
      MockDataConnectionChecker();
  NetworkInfoImpl networkInfo = NetworkInfoImpl(mockDataConnectionChecker);

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      final tHasConnection = Future.value(true);
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnection);
      final result = networkInfo.isConnected;
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, tHasConnection);
    });
  });
}
