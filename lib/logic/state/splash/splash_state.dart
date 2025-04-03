

class SplashState {
  final bool isLoading;
  final bool hasToken;

  const SplashState({
    this.isLoading = true,
    this.hasToken = false,
  });

  SplashState copyWith({
    bool? isLoading,
    bool? hasToken,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      hasToken: hasToken ?? this.hasToken,
    );
  }

  @override
  List<Object> get props => [isLoading, hasToken];
}