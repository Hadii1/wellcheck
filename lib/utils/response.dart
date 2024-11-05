import 'package:wellcheck/utils/enums.dart';

class Response<T> {
  final dynamic error;
  final T? data;
  final NetworkCallStatus status;

  Response({
    required this.error,
    required this.data,
    required this.status,
  });

  Response.loading({T? exisitingData})
      : error = '',
        data = exisitingData,
        status = NetworkCallStatus.loading;

  Response.completed(this.data)
      : error = '',
        status = NetworkCallStatus.success;

  Response.error(this.error)
      : status = NetworkCallStatus.error,
        data = null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Response<T> &&
        other.error == error &&
        other.data == data &&
        other.status == status;
  }

  @override
  int get hashCode => error.hashCode ^ data.hashCode ^ status.hashCode;
}
