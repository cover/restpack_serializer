require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'test.db'
)

ActiveRecord::Schema.define(:version => 1) do
  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.integer  "year"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", :force => true do |t|
    t.string   "title"
    t.integer  "album_id"
    t.integer  "artist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer "amount"
    t.integer  "artist_id"
    t.integer  "fan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fans", :force => true do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end

module MyApp
  class Artist < ActiveRecord::Base
    has_many :albums
    has_many :songs
    has_many :payments
    has_many :fans, :through => :payments
  end

  class Album < ActiveRecord::Base
    scope :classic, -> { where("year < 1950") }

    belongs_to :artist
    has_many :songs
  end

  class Song < ActiveRecord::Base
    default_scope -> { order(id: :asc) }

    belongs_to :artist
    belongs_to :album
  end

  class Payment < ActiveRecord::Base
    belongs_to :artist
    belongs_to :fan
  end

  class Fan < ActiveRecord::Base
    attr_accessible :name
    has_many :payments
    has_many :artists, :through => :albums
  end
end
