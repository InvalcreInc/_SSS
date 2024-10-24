import 'package:flutter/material.dart';

/// Supported [Markdown] formats
enum Supports {
  basic,
  image,
  charts,
  latex;

  /// Localised name
  /// todo: use [Localised(this).v]
  String get localisedName {
    switch (this) {
      case Supports.basic:
        return 'Основное';
      case Supports.image:
        return 'SVG/Изображения';
      case Supports.charts:
        return 'Графики';
      case Supports.latex:
        return 'LaTeX';
    }
  }

  ///
  /// Get a relative path used to test the support.
  String get relativePath {
    switch (this) {
      case Supports.basic:
        return 'docs/user-guide/ru/part04_loading/chapter06_containers/section01_type/section01_type.md';
      // return 'docs/user-guide/ru/part03_shipInfo/part03_shipInfo.md';
      case Supports.latex:
        // return 'docs/mock/latex/latex.md';
        return 'docs/user-guide/ru/part04_loading/chapter01_ballast/section02_table/section02_table.md';
      case Supports.image:
        return 'docs/mock/svg/svg.md';
      // return 'docs/user-guide/ru/part04_loading/chapter01_ballast/chapter01_ballast.md';
      case Supports.charts:
        return 'docs/mock/charts/simple.md';
    }
  }
}

///
/// Test docs navigation widget.
class DocsNavigationPanel extends StatelessWidget {
  final Supports current;
  final Function(Supports value) onSelected;

  ///
  /// Creates app main navigation widget.
  const DocsNavigationPanel({
    super.key,
    this.current = Supports.basic,
    required this.onSelected,
  });
  //
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final blockPadding = const Setting('blockPadding').toDouble;
    return Hero(
      tag: 'docs_navigation_panel',
      child: NavigationRail(
        groupAlignment: 0.0,
        labelType: NavigationRailLabelType.all,
        useIndicator: true,
        indicatorColor: theme.colorScheme.primary,
        selectedIconTheme: IconThemeData(
          color: theme.colorScheme.onPrimary,
        ),
        selectedLabelTextStyle: TextStyle(
          color: theme.colorScheme.primary,
        ),
        unselectedIconTheme: IconThemeData(
          color: theme.colorScheme.primary,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: theme.colorScheme.primary,
        ),
        destinations: [
          NavigationRailDestination(
            icon: const Icon(Icons.code_outlined),
            label: Text(Supports.basic.localisedName),
          ),
          NavigationRailDestination(
            icon: const Icon(Icons.image_outlined),
            selectedIcon: const Icon(Icons.image),
            label: Text(Supports.image.localisedName),
          ),
          NavigationRailDestination(
            icon: const Icon(Icons.bar_chart_outlined),
            selectedIcon: const Icon(Icons.bar_chart),
            label: Text(Supports.charts.localisedName),
          ),
          NavigationRailDestination(
            icon: const Icon(Icons.functions_outlined),
            selectedIcon: const Icon(Icons.functions),
            label: Text(Supports.latex.localisedName),
          ),
        ],
        selectedIndex: current.index,
        onDestinationSelected: (index) {
          if (index == current.index) return;
          onSelected(Supports.values[index]);
        },
      ),
    );
  }
}
