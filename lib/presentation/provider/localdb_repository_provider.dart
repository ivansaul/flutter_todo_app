import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/repositories/localdb_repository_hive_impl.dart';

final localDbRepositoryProvider = Provider<LocalDbRepositoryHiveImpl>((ref) {
  // Isar DB -> return LocalDbRepositoryIsarImpl();
  return LocalDbRepositoryHiveImpl();
});
