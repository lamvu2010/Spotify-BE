package ptithcm.entity;
import javax.persistence.*;
@Entity
@Table(name="LikedTracks")
public class LikedTracks {
	@Id
	@GeneratedValue
	@Column(name="Id_likedtracks")
	private Long id_likedtracks;
	@ManyToOne
	@JoinColumn(name="Id_track")
	private Track track;
	@ManyToOne
	@JoinColumn(name="Username")
	private User user;
	
	public LikedTracks() {
		
	}

	public Long getId_likedtracks() {
		return id_likedtracks;
	}

	public void setId_likedtracks(Long id_likedtracks) {
		this.id_likedtracks = id_likedtracks;
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
	
	
}
