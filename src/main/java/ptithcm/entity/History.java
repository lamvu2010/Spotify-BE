package ptithcm.entity;

import java.sql.Timestamp;

import javax.persistence.*;

@Entity
@Table(name = "History")
public class History {
	@Id
	@GeneratedValue
	@Column(name = "Id_history")
	private Long id_history;
	@ManyToOne
	@JoinColumn(name = "Id_track")
	private Track track;
	@ManyToOne
	@JoinColumn(name = "Username")
	private User user;
	@Column(name = "Time")
	private Timestamp time;
	
	public History() {
		
	}
	
	public Long getId_history() {
		return id_history;
	}
	public void setId_history(Long id_history) {
		this.id_history = id_history;
	}
	public Track getTrack() {
		return track;
	}
	public void setTrack(Track track) {
		this.track = track;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
}
