import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as md;
import 'package:sss/presentation/docs/widgets/loader.dart';

class FlutterMarkdownRender extends StatelessWidget {
  const FlutterMarkdownRender({super.key, required this.relativePath});
  final String relativePath;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return LoaderWidget(
          relativePath: relativePath,
          rendererBuilder: (data) => md.Markdown(
            data: data,
            // extensionSet: ,
          ),
        );
      }
    );
  }
}
