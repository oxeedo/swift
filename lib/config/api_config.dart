class ApiConfig {
  // TODO: Replace these with your actual API configuration
  
  /// Your API base URL - replace with your actual backend URL
  static const String baseUrl = 'https://your-api-domain.com/api';
  
  /// Your API key (if required) - replace with your actual API key
  static const String apiKey = 'your-api-key';
  
  /// Timeout duration for API requests in seconds
  static const int timeoutSeconds = 30;
  
  /// Whether to use HTTPS (recommended for production)
  static const bool useHttps = true;
  
  /// API version (if your API supports versioning)
  static const String apiVersion = 'v1';
  
  /// Get the full API URL with version
  static String get fullApiUrl {
    final protocol = useHttps ? 'https' : 'http';
    return '$protocol://$baseUrl/$apiVersion';
  }
  
  /// Get headers for API requests
  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (apiKey.isNotEmpty) 'Authorization': 'Bearer $apiKey',
    'X-API-Version': apiVersion,
  };
}
