bool isResponseSuccessful(final int? statusCode) => statusCode != null && statusCode >= 200 && statusCode < 300;

bool isResponseUnsuccessful(final int? statusCode) => !isResponseSuccessful(statusCode);
