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

  context.logger.err(
    'Invalid bundle ID "$bundleId". '
    'Expected at least 3 dot-separated segments, e.g. com.example.app.',
  );
  exit(1);
}
