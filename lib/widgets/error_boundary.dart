import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Error Boundary Widget
/// Catches and handles errors within its subtree to prevent full app crashes
/// Similar to React's Error Boundary pattern
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final void Function(Object, StackTrace?)? onError;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
    this.onError,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;

  @override
  void initState() {
    super.initState();
    // Reset error state when boundary is initialized
    _error = null;
    _stackTrace = null;
  }

  void _handleError(Object error, StackTrace? stackTrace) {
    setState(() {
      _error = error;
      _stackTrace = stackTrace;
    });

    // Call custom error handler if provided
    widget.onError?.call(error, stackTrace);

    // Log error for debugging
    debugPrint('ErrorBoundary caught error: $error');
    if (stackTrace != null) {
      debugPrint('Stack trace:\n$stackTrace');
    }
  }

  void _resetError() {
    setState(() {
      _error = null;
      _stackTrace = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // If there's an error, show error UI
    if (_error != null) {
      return widget.errorBuilder?.call(context, _error!, _stackTrace) ??
          _buildDefaultErrorUI(context);
    }

    // Wrap child with error handling
    return ErrorWidget.builder = (FlutterErrorDetails details) {
      // In production, show custom error UI
      if (!const bool.fromEnvironment('dart.vm.product', defaultValue: false)) {
        // Development mode - show detailed error
        return ErrorWidget(details.exception);
      }

      // Production mode - show user-friendly error
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleError(details.exception, details.stack);
      });

      return _buildDefaultErrorUI(context);
    };

    return widget.child;
  }

  Widget _buildDefaultErrorUI(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Material(
      child: Container(
        color: theme.scaffoldBackgroundColor,
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                l10n?.somethingWentWrong ?? 'Something went wrong',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                l10n?.errorOccurred ?? 'An unexpected error occurred',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _resetError,
                icon: const Icon(Icons.refresh),
                label: Text(l10n?.tryAgain ?? 'Try Again'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  _resetError();
                },
                child: Text(l10n?.goHome ?? 'Go to Home'),
              ),
              if (_error != null && !const bool.fromEnvironment('dart.vm.product'))
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Error Details (Debug Mode):',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _error.toString(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onErrorContainer,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simpler error widget for inline error states
class ErrorDisplay extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final Object? error;

  const ErrorDisplay({
    super.key,
    this.message,
    this.onRetry,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message ?? l10n?.somethingWentWrong ?? 'Something went wrong',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
            if (error != null && !const bool.fromEnvironment('dart.vm.product'))
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  error.toString(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onBackground.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(l10n?.tryAgain ?? 'Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Global error handler setup
/// Call this in main() to set up app-wide error handling
void setupErrorHandlers({
  void Function(Object, StackTrace)? onError,
}) {
  // Catch Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    onError?.call(details.exception, details.stack ?? StackTrace.empty);

    // Log to crash reporting service (e.g., Firebase Crashlytics)
    debugPrint('Flutter Error: ${details.exception}');
    debugPrint('Stack trace: ${details.stack}');
  };

  // Catch errors outside of Flutter context
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   onError?.call(error, stack);
  //   debugPrint('Platform Error: $error');
  //   debugPrint('Stack trace: $stack');
  //   return true;
  // };
}
