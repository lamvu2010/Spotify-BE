window.addEventListener("load", function() {
  // Lấy tham chiếu đến input file
  var fileInput = document.querySelector('input[type="file"][name="music"]');
  // Lấy tham chiếu đến input hidden
  var musicInput = document.querySelector('input[type="hidden"][name="music"]');
  // Lấy tham chiếu đến form
  var form = document.querySelector('form');
  // Lấy tham chiếu đến button
  var submitButton = document.querySelector('button[name="btnSubmit"]');
  // Tạo một FileReader
  var reader = new FileReader();
  // Khi đọc xong, lấy kết quả
  reader.onloadend = function() {
    // Kết quả là một chuỗi Base64 có dạng "data:audio/mp3;base64,*base64 string here*"
    var base64data = reader.result;
    // Gán chuỗi Base64 vào input hidden
    musicInput.value = base64data;
    // Gửi form
    form.submit();
  };
  // Thêm một sự kiện click cho button
  submitButton.addEventListener("click", function() {
    // Đọc file nhạc dưới dạng URL dữ liệu
    try {
      reader.readAsDataURL(fileInput.files[0]);
    } catch (error) {
      alert('Error reading file');
      console.log(error);
    }
    return false;
  });
});