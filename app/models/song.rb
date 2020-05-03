class Song < ActiveRecord::Base
    # validations
    validates :title, presence: true
    validates :title, uniqueness: {
        scope: %i[release_year artist_name],
        message: 'Cannot be repeated by the same artist in the same year'
    }
    validates :released, inclusion: { in: [true, false] }
    validates :artist_name, presence: true

    with_options if: :released? do |song|
        song.validates :release_year, presence: true
        song.validates :release_year, numericality: {
            less_than_or_equal_to: Date.today.year
        }
    end

    def released?
        released
    end

    def released_status
        if self.released == false
            self.release_year = "Song hasn't been released yet."
        else
            self.release_year
        end
    end
end