package ptithcm.controller;

import java.util.Random;

public class Support {
	// Hàm mã hóa caesar có số lẫn kí tự đặc biệt bằng Java
    public static String encrypt(String plainText) {
        //Khoảng cách
    	int shift=8;
    	// Chuyển chuỗi thành mảng ký tự
        char[] chars = plainText.toCharArray();
        // Duyệt qua mảng ký tự
        for (int i = 0; i < chars.length; i++) {
            // Lấy ký tự hiện tại
            char c = chars[i];
            // Chuyển ký tự về dạng số trong bảng mã ASCII
            int code = (int) c;
            // Kiểm tra nếu ký tự nằm trong khoảng từ 32 đến 126
            if (code >= 32 && code <= 126) {
                // Dịch chuyển ký tự theo khoảng cách shift
                code = (code - 32 + shift) % 95 + 32;
                // Chuyển ký tự về dạng chữ cái
                c = (char) code;
            }
            // Gán lại ký tự vào mảng
            chars[i] = c;
        }
        // Trả về chuỗi đã mã hóa
        return new String(chars);
    }

    // Hàm giải mã caesar có số lẫn kí tự đặc biệt bằng Java
    public static String decrypt(String cipherText) {
        //Khoảng cách
    	int shift=8;
    	// Chuyển chuỗi thành mảng ký tự
        char[] chars = cipherText.toCharArray();
        // Duyệt qua mảng ký tự
        for (int i = 0; i < chars.length; i++) {
            // Lấy ký tự hiện tại
            char c = chars[i];
            // Chuyển ký tự về dạng số trong bảng mã ASCII
            int code = (int) c;
            // Kiểm tra nếu ký tự nằm trong khoảng từ 32 đến 126
            if (code >= 32 && code <= 126) {
                // Dịch chuyển ký tự ngược lại theo khoảng cách shift
                code = (code - 32 - shift + 95) % 95 + 32;
                // Chuyển ký tự về dạng chữ cái
                c = (char) code;
            }
            // Gán lại ký tự vào mảng
            chars[i] = c;
        }
        // Trả về chuỗi đã giải mã
        return new String(chars);
    }
 // Một hàm để sinh một chuỗi ngẫu nhiên có độ dài 8 kí tự
    public static String generateRandomString() {
    	String ALPHANUMERIC = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

        // Một đối tượng Random để sinh số ngẫu nhiên
        Random RANDOM = new Random();
        // Một biến StringBuilder để lưu trữ chuỗi kết quả
        StringBuilder sb = new StringBuilder();

        // Một vòng lặp for để thêm 8 kí tự ngẫu nhiên vào sb
        for (int i = 0; i < 8; i++) {
            // Sinh một chỉ số ngẫu nhiên từ 0 đến ALPHANUMERIC.length() - 1
            int index = RANDOM.nextInt(ALPHANUMERIC.length());

            // Lấy kí tự tại vị trí index trong ALPHANUMERIC và thêm vào sb
            char c = ALPHANUMERIC.charAt(index);
            sb.append(c);
        }

        // Trả về chuỗi kết quả dưới dạng String
        return sb.toString();
    }
}
