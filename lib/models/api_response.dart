class ApiResponse {
  bool success;
  String message;
  Map<String, dynamic> data;

  ApiResponse(bool err, Map<String, dynamic> data) {
    if (err) {
      this.success = false;
      this.message = data['message'];
    } else {
      if (data['api_status'] == 1) {
        this.success = true;
        this.message = data['api_message'];
        this.data = data;
      } else {
        this.success = false;
        this.message = data['api_message'];
      }
    }
  }
}
