class StudentQuery {
  static String StudentAPIResponseFields() => """
    data {
      _id
      first_name
      last_name
      auth_info {
        institution_id
      }
      search_status {
      date_updated
      searching
      search_start
      search_end
      price_start
      price_end
      }
    }
    success
    error
  """;

  String createStudent(
      String firstName, String lastName, String email, String password,
      [String preferredEmail]) {
    return """
      mutation {
        createStudent(first_name: $firstName, last_name: $lastName, email: $email, password: $password, preferred_email: $preferredEmail) {
          ${StudentAPIResponseFields()}
        }
      }
    """;
  }
}
