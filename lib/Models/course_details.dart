class CourseDetails {
  final String courseName;
  final String imgUrl;
  final String offerPercent;
  final String instructorName;
  final String courseFees;
  final String courseLocation;
  bool isFavorite; // Track favorite state

  CourseDetails(this.courseName, this.imgUrl, this.offerPercent,
      this.instructorName, this.courseFees, this.courseLocation,
      {this.isFavorite = false});

  // convert a courseDetails object to map
  Map<String, dynamic> toMap() {
    return {
      'courseName': courseName,
      'imgUrl': imgUrl,
      'offerPercent': offerPercent,
      'instructorName': instructorName,
      'courseFees': courseFees,
      'courseLocation':courseLocation,
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
      map['courseLocation'] as String,
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }

  @override
  String toString() {
    return 'CourseDetails(courseName: $courseName, instructorName: $instructorName, courseFees: $courseFees, courseLocation: $courseLocation)';
  }
}
