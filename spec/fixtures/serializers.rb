module MyApp
  class SongSerializer
    include RestPack::Serializer
    attributes :id, :title, :album_id
    can_include :albums, :artists
    can_filter_by :title
    allow_parameters :created_at

    def title
      @context[:reverse_title?] ? @model.title.reverse : @model.title
    end
  end

  class AlbumSerializer
    include RestPack::Serializer
    attributes :id, :title, :year, :artist_id
    can_include :artists, :songs
    can_filter_by :year
  end

  class ArtistSerializer
    include RestPack::Serializer
    attributes :id, :name, :website
    can_include :albums, :songs
  end
end
