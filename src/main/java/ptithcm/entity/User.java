package ptithcm.entity;

import java.sql.Date;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="[User]")
public class User {
	@Id
	@Column(name="Username")
	@NotBlank(message="Vui lòng nhập username")
	private String username;
	@Column(name="Password")
	@NotBlank(message="Vui lòng nhập password")
	private String password;
	@Column(name="Fullname")
	@NotBlank(message="Vui lòng nhập họ và tên của bạn")
	private String fullname;
	@Column(name="Birthday")
	private Date birthday;
	@Column(name="Phonenumber")
	@NotBlank(message="Vui lòng nhập số điện thoại")
	private String phonenumber;
	@Column(name="Nation")
	@NotBlank(message="Vui lòng nhập quốc gia")
	private String nation;
	@Column(name="Email")
	@NotBlank(message="Vui lòng nhập email")
	private String email;
	@Column(name="Lock")
	private Boolean lock;
	@Column(name="Permission")
	private String permission;
	
	public User() {
		lock=false;
		permission="Audience";
	}
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Boolean getLock() {
		return lock;
	}
	public void setLock(Boolean lock) {
		this.lock = lock;
	}
	public String getPermission() {
		return permission;
	}
	public void setPermission(String permission) {
		this.permission = permission;
	}
	
}
