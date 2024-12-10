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
  @override
  String toString() {
    return 'CourseDetails(courseName: $courseName, instructorName: $instructorName, courseFees: $courseFees)';
  }
}