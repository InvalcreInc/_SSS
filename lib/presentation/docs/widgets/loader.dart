import 'package:flutter/material.dart';
import 'package:sss/presentation/core/docs/docs_loader.dart';
import 'package:sss/presentation/core/widgets/future_builder_widget.dart';

///
/// A widget that safely loads the local [Mockdown]
/// docs using the [DocsLoader].
class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    super.key,
    required this.relativePath,
    required this.rendererBuilder,
  });

  final String relativePath;
  final Widget Function(String data) rendererBuilder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilderWidget<String>(
      onFuture: () => DocsLoader.loadMDDoc(relativePath, context),
      caseData: (context, data, __) => rendererBuilder(data),
    );
  }
}
