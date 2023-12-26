part of 'view.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Future<void> onPreloadComplete(BuildContext context) async {
    final navigator = Navigator.of(context);
    await Future<void>.delayed(AnimatedProgressBar.intrinsicAnimationDuration);
    if (!mounted) {
      return;
    }
    await navigator.pushReplacement<void, void>(GamePage.route());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoadingCubit, LoadingState>(
      listenWhen: (prevState, state) =>
          !prevState.isComplete && state.isComplete,
      listener: (context, state) => onPreloadComplete(context),
      child: const Scaffold(
        backgroundColor: Color(0xFF000000),
        body: Center(
          child: _LoadingInternal(),
        ),
      ),
    );
  }
}

class _LoadingInternal extends StatelessWidget {
  const _LoadingInternal();

  @override
  Widget build(BuildContext context) {
    final primaryTextTheme = Theme.of(context).primaryTextTheme;

    return BlocBuilder<LoadingCubit, LoadingState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AnimatedProgressBar(
                progress: state.progress,
                backgroundColor: const Color(0xFFFFFFFF),
                foregroundColor: const Color(0xFFFF1133),
              ),
            ),
            Text(
              'Loading ${state.currentLabel}...',
              style: primaryTextTheme.bodySmall!.copyWith(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        );
      },
    );
  }
}
