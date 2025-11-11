import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      tileColor: UiColors.bgWhite,
      title: Text(
        title,
        style: UiTextStyle.body16(
          color: UiColors.secondaryBase,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle!, maxLines: 2) : null,
      onTap: onTap,
    );
  }
}
