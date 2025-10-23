// Conteúdo para: lib/theme/widgets/responsive_center.dart

import 'package:flutter/material.dart';

/// Limita a largura do conteúdo em telas grandes (web)
/// para manter um layout legível e profissional.
class ResponsiveCenter extends StatelessWidget {
  final Widget child;

  const ResponsiveCenter({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        // Define a largura máxima do seu conteúdo
        constraints: const BoxConstraints(maxWidth: 500),
        child: child,
      ),
    );
  }
}