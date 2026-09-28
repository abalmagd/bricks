import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  _validateName(context);
  _validateBundleId(context);
}

void _validateName(HookContext context) {
  final name = context.vars['name'] as String;
  if (RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*( [a-zA-Z][a-zA-Z0-9_]*)*$').hasMatch(name)) return;

  context.logger.err(
    'Invalid name "$name". '
    'Must start with a letter and contain only letters, digits, underscores, and single spaces between words.',
  );
  exit(1);
}

void _validateBundleId(HookContext context) {
  final bundleId = context.vars['bundle_id'] as String;
  if (RegExp(r'^[a-zA-Z][a-zA-Z0-9]*(\.[a-zA-Z][a-zA-Z0-9]*){2,}$').hasMatch(bundleId)) return;

  if (bundleId.contains(' ')) {
    final suggested = bundleId.replaceAll(' ', '');
    context.logger.err(
      'Invalid bundle ID "$bundleId". '
      'Bundle IDs cannot contain spaces. Try: $suggested',
    );
    exit(1);
  }

  if (bundleId.contains('-')) {
    context.logger.err(
      'Invalid bundle ID "$bundleId". '
      'Hyphens (-) are not allowed — they are invalid in Android package names. '
      'Replace with nothing or a dot, e.g. dev.abulmagd.myapp',
    );
    exit(1);
  }

  if (bundleId.contains('_')) {
    context.logger.err(
      'Invalid bundle ID "$bundleId". '
      'Underscores (_) are not allowed — they are invalid in iOS bundle identifiers. '
      'Replace with nothing or a dot, e.g. dev.abulmagd.myapp',
    );
    exit(1);
  }

  final segments = bundleId.split('.');
  if (segments.length < 3) {
    context.logger.err(
      'Invalid bundle ID "$bundleId". '
      'Must have at least 3 dot-separated segments, e.g. dev.abulmagd.myapp',
    );
    exit(1);
  }

  for (final segment in segments) {
    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9]*$').hasMatch(segment)) {
      context.logger.err(
        'Invalid bundle ID segment "$segment" in "$bundleId". '
        'Each segment must start with a letter and contain only letters and digits.',
      );
      exit(1);
    }
  }

  context.logger.err(
    'Invalid bundle ID "$bundleId". '
    'Use only letters, digits, and dots, with at least 3 segments, e.g. dev.abulmagd.myapp',
  );
  exit(1);
}
