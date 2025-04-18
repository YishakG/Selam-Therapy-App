/// Splash screen widget that displays the app's initial loading screen.
/// This screen handles initial app setup and navigation to the appropriate screen.
/// Example usage:
/// ```dart
/// class SplashScreen extends StatefulWidget {
///   const SplashScreen({Key? key}) : super(key: key);
/// 
///   @override
///   State<SplashScreen> createState() => _SplashScreenState();
/// }
/// 
/// class _SplashScreenState extends State<SplashScreen> {
///   @override
///   void initState() {
///     super.initState();
///     _initializeApp();
///   }
/// 
///   Future<void> _initializeApp() async {
///     // Add initialization logic here
///     await Future.delayed(const Duration(seconds: 2));
///     
///     if (mounted) {
///       Navigator.of(context).pushReplacement(
///         MaterialPageRoute(
///           builder: (_) => const HomeScreen(),
///         ),
///       );
///     }
///   }
/// 
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: [
///             Image.asset('assets/logo.png'),
///             const SizedBox(height: 24),
///             const CircularProgressIndicator(),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ``` 