package ptithcm.entity;

import java.time.LocalDate;
import java.sql.Date;
import java.lang.Long;

import javax.persistence.*;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.validator.constraints.NotBlank;

@Entity
@Table(name="Track")
public class Track {
	@Id
	@GeneratedValue
	@Column(name="Id_track")
	private Long id_track;
	@Column(name="Name")
	@NotBlank(message="Vui lòng nhập name")
	private String name;
	@Column(name="Path")
	private String path;
	@Column(name="UploadDate")
	@CreationTimestamp
	private Date uploadDate;
	@Column(name="[Like]")
	private Long like;
	@ManyToOne
	@JoinColumn (name="Id_genre")
	private Genre genre;
	@Column(name="Image")
	private String image;
	@ManyToOne
	@JoinColumn (name="Username")
	private User user;
	@Column(name="IsPublic")
	private boolean isPublic;
	@Column(name="Status")
	private String status;
	public Track() {
		isPublic=false;
		status="pending";
		like=Long.valueOf(0);
		setUploadDate(Date.valueOf(LocalDate.now()));
	}
	
	public Long getId_track() {
		return id_track;
	}
	public void setId_track(Long i) {
		this.id_track = i;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Date getUploadDate() {
		return uploadDate;
	}
	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}
	public Long getLike() {
		return like;
	}
	public void setLike(Long like) {
		this.like = like;
	}
	public Genre getGenre() {
		return genre;
	}
	public void setGenre(Genre genre) {
		this.genre = genre;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	public boolean getIsPublic() {
		return isPublic;
	}

	public void setIsPublic(boolean isPublic) {
		this.isPublic = isPublic;
	}
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
