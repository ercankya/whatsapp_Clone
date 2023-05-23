import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/feature/contact/repository/contact_repository.dart';

final contactControllerProvider = FutureProvider((ref) {
  final contactRepository = ref.watch(contactRepositoryProvider);
  return contactRepository.getAllContacts();
});
