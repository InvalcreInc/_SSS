import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:sss/presentation/docs/markdown_widget/custom_node.dart';
import 'package:sss/presentation/docs/markdown_widget/latex.dart';
import 'package:sss/presentation/docs/widgets/loader.dart';

class MarkdownWidgetRender extends StatelessWidget {
  const MarkdownWidgetRender({super.key, required this.relativePath});
  final String relativePath;

  @override
  Widget build(BuildContext context) {
    return LoaderWidget(
      relativePath: relativePath,
      rendererBuilder: (data) => MarkdownWidget(
        data: data,
        config: MarkdownConfig(
          configs: [
            TableConfig(
              defaultColumnWidth: IntrinsicColumnWidth(
                flex: 1,
              ),
            ),
          ],
        ),
        markdownGenerator: MarkdownGenerator(
          textGenerator: (node, config, visitor) =>
              CustomTextNode(node.textContent, config, visitor),
          generators: [
            SpanNodeGeneratorWithTag(
              tag: 'latex',
              generator: (e, config, visitor) => LatexNode(
                e.attributes,
                e.textContent,
                config,
              ),
            ),
            SpanNodeGeneratorWithTag(
              tag: 'img',
              generator: (e, config, visitor) {
                final url = e.attributes['src'] ?? '';
                final bool isSvg = url.endsWith('.svg');
                final isNet = url.startsWith('http');
                final attr = isNet
                    ? e.attributes
                    : {
                        'src': url.replaceFirst('/assets', ''),
                        'alt': e.attributes['alt'] ?? ''
                      };
                if (isSvg) {
                  return SvgNode(
                    attributes: attr,
                    config: config,
                  );
                }
                return ImageNode(attr, config, visitor);
              },
            )
          ],
          inlineSyntaxList: [
            LatexSyntax(),
          ],
        ),
      ),
    );
  }
}

class SvgNode extends SpanNode {
  final Map<String, String> attributes;
  final MarkdownConfig config;

  SvgNode({required this.attributes, required this.config});

  @override
  InlineSpan build() {
    final url = attributes['src'] ?? '';
    final alt = attributes['alt'] ?? '';
    final isNetSvg = url.startsWith('http');
    final imgWidget = isNetSvg
        ? SvgPicture.network(url,
            semanticsLabel: alt, headers: {'Content-Type': 'image/svg+xml'})
        : SvgPicture.asset(url, semanticsLabel: alt);
    return WidgetSpan(child: imgWidget);
  }
}
