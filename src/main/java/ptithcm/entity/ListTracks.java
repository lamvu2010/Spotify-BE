package ptithcm.entity;
import javax.persistence.*;
@Entity
@Table(name="ListTracks")
public class ListTracks {
	@Id
	@GeneratedValue
	@Column(name="Id_listtracks")
	private Long id_listtracks;
	@ManyToOne
	@JoinColumn(name="Id_playlist")
	private Playlist playlist;
	@ManyToOne
	@JoinColumn(name="Id_track")
	private Track track;
	
	public ListTracks() {
		
	}

	public Long getId_listtracks() {
		return id_listtracks;
	}

	public void setId_listtracks(Long id_listtracks) {
		this.id_listtracks = id_listtracks;
	}

	public Playlist getPlaylist() {
		return playlist;
	}

	public void setPlaylist(Playlist playlist) {
		this.playlist = playlist;
	}

	public Track getTrack() {
		return track;
	}

	public void setTrack(Track track) {
		this.track = track;
	}
	
	
}
