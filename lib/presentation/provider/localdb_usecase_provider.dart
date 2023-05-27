import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/localdb_usecase_impl.dart';
import 'localdb_repository_provider.dart';

final localDbUsecaseProvider = Provider<LocalDbUsecaseImpl>((ref) {
  final localDbRepository = ref.watch(localDbRepositoryProvider);
  return LocalDbUsecaseImpl(localDbRepository);
});
