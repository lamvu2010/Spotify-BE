package ptithcm.entity;

import java.sql.Date;
import java.time.LocalDate;

import javax.persistence.*;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.validator.constraints.NotBlank;

@Entity
@Table(name="Playlist")
public class Playlist {
	@Id
	@GeneratedValue
	@Column(name="Id_playlist")
	private Long id_playlist;
	@Column(name="Name")
	@NotBlank(message="Please input name")
	private String name;
	@Column(name="CreatedDate")
	@CreationTimestamp
	private Date createdDate;
	@Column(name="Image")
	private String image;
	@ManyToOne
	@JoinColumn(name="Username")
	private User user;
	@Column(name="IsPublic")
	private boolean isPublic;
	@Column(name="Status")
	private String status;
	public Playlist() {
		isPublic=false;
		status="pending";
		setCreatedDate(Date.valueOf(LocalDate.now()));
	}
	
	public Long getId_playlist() {
		return id_playlist;
	}
	public void setId_playlist(Long id_playlist) {
		this.id_playlist = id_playlist;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
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
