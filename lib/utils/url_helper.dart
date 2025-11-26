import 'package:url_launcher/url_launcher.dart';

Future<void> abrirLink(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    throw Exception('Não foi possível abrir o link: $url, Erro; $e');
  }
}
