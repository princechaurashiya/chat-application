String generateChatRoomId(String uid1, String uid2) {
  print(" call chatrome id fun");
  return uid1.hashCode <= uid2.hashCode ? '$uid1-$uid2' : '$uid2-$uid1';
}
