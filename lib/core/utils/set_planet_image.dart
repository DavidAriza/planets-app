String setPlanetImage(String planetName) {
  switch (planetName.toLowerCase()) {
    case 'mercury':
      return 'https://upload.wikimedia.org/wikipedia/commons/4/4a/Mercury_in_true_color.jpg';
    case 'venus':
      return 'https://upload.wikimedia.org/wikipedia/commons/b/b2/Venus_2_Approach_Image.jpg';
    case 'earth':
      return 'https://upload.wikimedia.org/wikipedia/commons/9/97/The_Earth_seen_from_Apollo_17.jpg';
    case 'mars':
      return 'https://upload.wikimedia.org/wikipedia/commons/0/02/OSIRIS_Mars_true_color.jpg';
    case 'jupiter':
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Jupiter.jpg/400px-Jupiter.jpg';
    case 'saturn':
      return 'https://upload.wikimedia.org/wikipedia/commons/c/c7/Saturn_during_Equinox.jpg';
    case 'uranus':
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Uranus_Voyager2_color_calibrated.png/800px-Uranus_Voyager2_color_calibrated.png';
    case 'neptune':
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Neptune_Full.jpg/200px-Neptune_Full.jpg';
    default:
      return '';
  }
}
