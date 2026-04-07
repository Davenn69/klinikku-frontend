import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'base_notifier.dart';

class BaseView<T extends BaseNotifier> extends ConsumerWidget {
  final AutoDisposeChangeNotifierProvider<T> provider;
  final Widget Function(BuildContext, T) builder;
  final Widget Function(BuildContext, T)? overlayBuilder;
  final PreferredSizeWidget Function(T)? appBar;
  final bool extendBodyBehindAppBar;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool resizeToAvoidBottomInset;

  const BaseView({
    super.key,
    required this.provider,
    this.appBar,
    required this.builder,
    this.overlayBuilder,
    this.extendBodyBehindAppBar = false,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewModel = ref.watch(provider);
    return _buildScreenContent(context, viewModel);
  }

  Widget _buildScreenContent(BuildContext context, T viewModel) => Stack(
    children: [
      GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: appBar != null ? appBar!(viewModel) : null,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBody: true,
          body:
              (!viewModel.isInitialized)
                  ? const LoadingIndicator()
                  : Stack(
                    children: [
                      builder(context, viewModel),
                      if (viewModel.showOverlay && overlayBuilder != null)
                        overlayBuilder!(context, viewModel),
                    ],
                  ),
        ),
      ),
      if (viewModel.isLoading &&
          !viewModel.showOverlay &&
          viewModel.isInitialized)
        const LoadingIndicator(showBackdrop: true),
    ],
  );
}
