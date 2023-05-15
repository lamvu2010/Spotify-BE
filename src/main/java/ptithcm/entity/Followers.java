package ptithcm.entity;

import java.sql.Date;

import javax.persistence.*;

@Entity
@Table(name="Followers")
public class Followers {
	@Id
	@GeneratedValue
	@Column(name="Id_followers")
	private Long id_followers;
	@ManyToOne
	@JoinColumn(name="Id_artist")
	private User artist;
	@ManyToOne
	@JoinColumn(name="Username")
	private User user;
	@Column(name="FollowDate")
	private Date followDate;
	
	public Followers() {
		
	}
	
	public Long getId_followers() {
		return id_followers;
	}
	public void setId_followers(Long id_followers) {
		this.id_followers = id_followers;
	}
	public User getArtist() {
		return artist;
	}
	public void setArtist(User artist) {
		this.artist = artist;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getFollowDate() {
		return followDate;
	}
	public void setFollowDate(Date followDate) {
		this.followDate = followDate;
	}
	
}
