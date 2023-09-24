class FilmSizesList {
  static const List<String> conditions = [
    'type 135',
    'type 120',
    'type 126',
    'type 110',
    'type 220',
    'type 620',
    'type 828',
    'APS',
  ];

  // Add a map to associate film sizes with default frame numbers
  static const Map<String, int> defaultFrameNumbers = {
    'type 135': 36,
    'type 120': 12,
    'type 126': 0,
    'type 110': 0,
    'type 220': 0,
    'type 828': 0,
    'type 620': 0,
    'APS': 15,
  };
}

