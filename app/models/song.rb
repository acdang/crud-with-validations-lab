class Song < ApplicationRecord
    validates :title, presence: true, uniqueness: { scope: :release_year, message: "cannot be repeated by the same artist in the same year"}
    validates :released, inclusion: [true, false]
    validates :released, exclusion: [nil]
    validates :release_year, presence: true, if: :released_is_true?
    validate :release_year_cannot_be_a_future_year
    validates :artist_name, presence: true

    def released_is_true?
        released == true
    end

    def release_year_cannot_be_a_future_year
        # need to check if release_year is NOT nil before checking if it's in the future
        if release_year && release_year > Date.today.year
            errors.add(:release_year)
        end
    end
end
