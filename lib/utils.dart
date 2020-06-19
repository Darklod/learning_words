get currentTimestamp {
  return DateTime.now().toUtc().millisecondsSinceEpoch;
}

DateTime getDate(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
}

// date formatting