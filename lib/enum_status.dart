enum TaskStatus {
  newStatus, // "New"
  close, // "Close"
  assigned, // "Assigned"
  hold, // "Hold"
  accepted, // "Accepted",
  claimed,
  released
}

// Ekstensi untuk mendapatkan nilai string dari enum
extension TaskStatusExtension on TaskStatus {
  String get value {
    switch (this) {
      case TaskStatus.newStatus:
        return "New";
      case TaskStatus.close:
        return "Close";
      case TaskStatus.assigned:
        return "Assigned";
      case TaskStatus.hold:
        return "Hold";
      case TaskStatus.accepted:
        return "Accepted";
      case TaskStatus.claimed:
        return "Claimed";
      case TaskStatus.released:
        return "Released";
    }
  }

  // Untuk mendapatkan enum dari string
  static TaskStatus fromString(String status) {
    switch (status) {
      case "New":
        return TaskStatus.newStatus;
      case "Close":
        return TaskStatus.close;
      case "Assigned":
        return TaskStatus.assigned;
      case "Hold":
        return TaskStatus.hold;
      case "Accepted":
        return TaskStatus.claimed;
      case "Claimed":
        return TaskStatus.released;
      case "Released":
        return TaskStatus.accepted;
      default:
        throw ArgumentError("Invalid status: $status");
    }
  }
}
