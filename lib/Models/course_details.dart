class CourseDetails {
  final String courseName;
  final String imgUrl;
  final String offerPercent;
  final String instructorName;
  final String courseFees;
  bool isFavorite; // Track favorite state

  CourseDetails(this.courseName, this.imgUrl, this.offerPercent,
      this.instructorName, this.courseFees,
      {this.isFavorite = false});

  // convert a courseDetails object to map
  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'imgUrl': imgUrl,
      'offerPercent': offerPercent,
      'instructorName': instructorName,
      'courseFees': courseFees,
      'isFavorite': isFavorite,
    };
  }

  // create a courseDetails object from map
  factory CourseDetails.fromMap(Map<String, dynamic> map) {
    return CourseDetails(
      map['courseName'] as String,
      map['imgUrl'] as String,
      map['offerPercent'] as String,
      map['instructorName'] as String,
      map['courseFees'] as String,
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }

  @override
  String toString() {
    return 'CourseDetails(courseName: $courseName, instructorName: $instructorName, courseFees: $courseFees)';
  }
}
