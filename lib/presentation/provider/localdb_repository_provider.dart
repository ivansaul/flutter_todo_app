import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../infrastructure/repositories/localdb_repository_isar_impl.dart';

final localDbRepositoryProvider = Provider<LocalDbRepositoryIsarImpl>((ref) {
  return LocalDbRepositoryIsarImpl();
});
