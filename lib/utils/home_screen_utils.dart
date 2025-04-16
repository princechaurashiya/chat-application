import 'package:chat/models/user_model.dart';

List<UserModel> sortUsersByStatus(
  List<UserModel> allUsers,
  List<String> onlineUserIds,
) {
  final sortedUsers = [...allUsers]; // original list ko mutate na karo

  sortedUsers.sort((a, b) {
    final isAOnline = onlineUserIds.contains(a.id);
    final isBOnline = onlineUserIds.contains(b.id);

    if (isAOnline && !isBOnline) return -1;
    if (!isAOnline && isBOnline) return 1;

    final nameA = a.name ?? '';
    final nameB = b.name ?? '';
    return nameA.compareTo(nameB);
  });

  return sortedUsers;
}
