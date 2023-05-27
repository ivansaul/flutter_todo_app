import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/localdb_repository_impl.dart';
import '../../data/localdb_usecase_impl.dart';

final localDbRepositoryProvider = Provider<LocalDbRepositoryImpl>((ref) {
  return LocalDbRepositoryImpl();
});

final localDbUsecaseProvider = Provider<LocalDbUsecaseImpl>((ref) {
  final localDbRepository = ref.watch(localDbRepositoryProvider);
  return LocalDbUsecaseImpl(localDbRepository);
});
