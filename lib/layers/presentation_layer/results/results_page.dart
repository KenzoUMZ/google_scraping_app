import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/core.dart';
import '../../domain_layer/domain_layer.dart';
import 'widgets/blurred_app_bar.dart';
import 'widgets/search_result_tile.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late final SearchInternetController _controller;

  @override
  void initState() {
    super.initState();

    _controller = GetIt.I.get<SearchInternetController>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchInternetController, SearchInternetState>(
      bloc: _controller,
      builder: (_, state) {
        final response = state.searchResponse;
        final results = response?.results ?? [];
        return Scaffold(
          backgroundColor: UiColors.bgSoft,
          extendBodyBehindAppBar: true,
          appBar: BlurredAppBar(title: response?.searchTerm ?? 'Results'),
          body: SafeArea(
            child:
                results.isEmpty
                    ? Center(
                      child: Text(
                        response == null
                            ? 'No search data.'
                            : 'No results found for "${response.searchTerm ?? ''}"',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                    : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      itemCount: results.length,
                      separatorBuilder: (context, index) => Gap(8),
                      itemBuilder: (_, index) {
                        final item = results[index];
                        final normalizedUrl = UrlUtils.normalizeUrl(item.url);
                        return SearchResultTile(
                          title: item.title ?? normalizedUrl ?? 'No title',
                          subtitle: normalizedUrl,
                          onTap: () async {
                            await _openUrl(item.url);
                          },
                        );
                      },
                    ),
          ),
        );
      },
    );
  }
}

extension on _ResultsPageState {
  Future<void> _openUrl(String? url) async {
    // Normaliza a URL primeiro
    final normalizedUrl = UrlUtils.normalizeUrl(url);

    if (normalizedUrl == null || normalizedUrl.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('URL inválida')));
      }
      return;
    }

    final uri = Uri.tryParse(normalizedUrl);
    if (uri == null || !UrlUtils.isValidUrl(normalizedUrl)) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('URL inválida')));
      }
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o link')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erro ao abrir o link')));
      }
    }
  }
}
