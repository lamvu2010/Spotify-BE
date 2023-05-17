package ptithcm.entity;
import javax.persistence.*;
@Entity
@Table(name="InformationTrack")
public class InformationTrack {
	@Id
	@GeneratedValue
	@Column(name="Id_information")
	private Long id_information;
	@ManyToOne
	@JoinColumn(name="Id_track")
	private Track track;
	@ManyToOne
	@JoinColumn(name="Id_artist")
	private User artist;
	
	public InformationTrack() {
		
	}
	
	public InformationTrack(Track track, User artist) {
		this.track=track;
		this.artist=artist;
	}

	public Long getId_information() {
		return id_information;
	}

	public void setId_information(Long id_information) {
		this.id_information = id_information;
	}

	public Track getTrack() {
		return track;
	}

	public void setTrack(Track track) {
		this.track = track;
	}

	public User getArtist() {
		return artist;
	}

	public void setArtist(User artist) {
		this.artist = artist;
	}
	
}
