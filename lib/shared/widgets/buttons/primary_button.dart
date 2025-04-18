/// A reusable primary button widget with consistent styling.
/// This button follows the app's design system and includes loading state handling.
/// Example usage:
/// ```dart
/// class PrimaryButton extends StatelessWidget {
///   final String text;
///   final VoidCallback onPressed;
///   final bool isLoading;
///   final bool isDisabled;
///   final double? width;
/// 
///   const PrimaryButton({
///     Key? key,
///     required this.text,
///     required this.onPressed,
///     this.isLoading = false,
///     this.isDisabled = false,
///     this.width,
///   }) : super(key: key);
/// 
///   @override
///   Widget build(BuildContext context) {
///     return SizedBox(
///       width: width,
///       child: ElevatedButton(
///         onPressed: isDisabled || isLoading ? null : onPressed,
///         style: ElevatedButton.styleFrom(
///           padding: const EdgeInsets.symmetric(vertical: 16),
///           shape: RoundedRectangleBorder(
///             borderRadius: BorderRadius.circular(8),
///           ),
///         ),
///         child: isLoading
///             ? const CircularProgressIndicator()
///             : Text(text),
///       ),
///     );
///   }
/// }
/// ``` 