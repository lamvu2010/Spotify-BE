package ptithcm.entity;

import javax.persistence.*;

@Entity
@Table(name="Genre")
public class Genre {
	@Id
	@GeneratedValue
	@Column(name="Id_genre")
	private Long id_genre;
	@Column(name="Type")
	private String type;
	public Genre() {
		
	}
	public Long getId_genre() {
		return id_genre;
	}
	public String getType() {
		return type;
	}
	public void setId_genre(Long id_genre) {
		this.id_genre=id_genre;
	}
	public void setType(String type) {
		this.type=type;
	}
}
