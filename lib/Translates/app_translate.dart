import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'english': 'English',
          'Don\'t have an account': 'Don\'t have an account',
        },
        'kh_KH': {
          'Khmer': 'ខ្មែរ',
          'Don\'t have an account': 'មិនមានគណនីទេ',
        },
        // Add more languages here
      };
}