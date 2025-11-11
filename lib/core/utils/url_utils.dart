class UrlUtils {
  UrlUtils._();

  /// Normaliza URLs que vêm com caracteres especiais como › em vez de /
  static String? normalizeUrl(String? url) {
    if (url == null || url.isEmpty) return null;

    // Remove espaços extras
    var normalized = url.trim();

    // Substitui › por /
    normalized = normalized.replaceAll('›', '/');
    
    // Substitui múltiplos espaços por nada
    normalized = normalized.replaceAll(RegExp(r'\s+'), '');

    // Garante que tem o protocolo
    if (!normalized.startsWith('http://') && !normalized.startsWith('https://')) {
      normalized = 'https://$normalized';
    }

    // Garante que termina com /
    if (!normalized.endsWith('/')) {
      normalized = '$normalized/';
    }

    return normalized;
  }

  /// Valida se uma URL é válida
  static bool isValidUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    
    return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
  }
}
