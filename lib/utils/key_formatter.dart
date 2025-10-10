/// Utility class for formatting configuration keys
class KeyFormatter {
  /// Format key to UPPERCASE_SNAKE_CASE with group prefix
  /// Example: formatKey('Auth0', 'audience') -> 'AUTH0_AUDIENCE'
  static String formatKey(String groupName, String keyName) {
    final group = toSnakeCase(groupName).toUpperCase();
    final key = toSnakeCase(keyName).toUpperCase();
    return '${group}_$key';
  }

  /// Convert string to snake_case
  /// Example: 'Auth0' -> 'auth0', 'clientId' -> 'client_id'
  static String toSnakeCase(String input) {
    // Replace spaces and hyphens with underscores
    var result = input.replaceAll(' ', '_').replaceAll('-', '_');
    
    // Insert underscore before uppercase letters that follow lowercase/numbers (for camelCase)
    result = result.replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
      (match) => '${match.group(1)}_${match.group(2)}',
    );
    
    // Convert to lowercase
    result = result.toLowerCase();
    
    // Remove any duplicate underscores
    result = result.replaceAll(RegExp(r'_+'), '_');
    
    // Remove leading/trailing underscores
    result = result.replaceAll(RegExp(r'^_+|_+$'), '');
    
    return result;
  }

  /// Convert string to camelCase
  /// Example: 'Auth0 Audience' -> 'auth0Audience', 'DataDog AppId' -> 'dataDogAppId'
  static String toCamelCase(String input) {
    // First, split camelCase words (e.g., "DataDog" -> "Data Dog")
    var processed = input.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    );
    
    // Replace spaces, hyphens, and underscores with a marker for splitting
    final words = processed
        .replaceAll(RegExp(r'[-_\s]+'), ' ')
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();
    
    if (words.isEmpty) return '';
    
    // First word lowercase, rest capitalized
    final result = words.first.toLowerCase() +
        words.skip(1).map((word) {
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        }).join('');
    
    return result;
  }
}
