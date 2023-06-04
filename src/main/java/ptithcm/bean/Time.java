package ptithcm.bean;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Time {

	private String day;
	private String month;
	private String year;
	
	public Time() {
		
	}
	
	public Time(String day, String month, String year) {
		super();
		this.day = day;
		this.month = month;
		this.year = year;
	}
	
	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}
	
	public java.sql.Date getSqlDate() throws ParseException{
		if(month.length()==1)month="0"+month;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		java.util.Date utilDate=format.parse(this.year+"-"+this.month+"-"+this.day);
		long time = utilDate.getTime();
		java.sql.Date sqlDate= new java.sql.Date(time);
		return sqlDate;
	}
	public void initBySqlDate(java.sql.Date date) {

		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int day = cal.get(Calendar.DAY_OF_MONTH); // lấy giá trị ngày
		int month = cal.get(Calendar.MONTH) + 1; // lấy giá trị tháng (cộng 1 vì tháng bắt đầu từ 0)
		int year = cal.get(Calendar.YEAR); // lấy giá trị năm

		this.day = String.valueOf(day);
		this.month = String.valueOf(month);
		this.year = String.valueOf(year);
	}
}
