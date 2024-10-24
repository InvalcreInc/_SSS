import 'package:flutter/material.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';
import 'package:sss/presentation/docs/flutter_markdown/renderer.dart';
import 'package:sss/presentation/docs/markdown_widget/renderer.dart';
import 'package:sss/presentation/docs/widgets/navigation_panel.dart';

///
/// The page to render local [Mockdown] docs.
class DocsPage extends StatefulWidget {
  const DocsPage({super.key});

  @override
  State<DocsPage> createState() => _DocsPageState();
}

class _DocsPageState extends State<DocsPage> with TickerProviderStateMixin {
  late TabController _tabController;
  Supports _supports = Supports.basic;
  String _relativePath = Supports.basic.relativePath;

  ///
  late List<Tab> _tabs;

  @override
  void initState() {
    _tabs = ['flutter_markdown', 'markdown_widget']
        .map(
          (e) => Tab(
            text: e,
          ),
        )
        .toList();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blockPadding = const Setting('blockPadding').toDouble;
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(blockPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: DocsNavigationPanel(
                current: _supports,
                onSelected: (selected) {
                  setState(() {
                    _supports = selected;
                    _relativePath = selected.relativePath;
                  });
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _tabController.animateTo(
                        _tabController.index == _tabs.length - 1 ? 0 : 1);
                  });
                },
              ),
            ),
            SizedBox(width: blockPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    controller: _tabController,
                    indicatorColor: theme.colorScheme.primary,
                    tabs: _tabs,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                  ),
                  SizedBox(height: blockPadding),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        FlutterMarkdownRender(
                          relativePath: _relativePath,
                        ),
                        MarkdownWidgetRender(
                          relativePath: _relativePath,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
