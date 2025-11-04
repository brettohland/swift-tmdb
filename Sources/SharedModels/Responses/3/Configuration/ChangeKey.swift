import Foundation

public extension TMDBInternal.Configuration {
    enum ChangeKey: String, Codable {
        case adult
        case airDate = "air_date"
        case alsoKnownAs = "also_known_as"
        case alternativeTitles = "alternative_titles"
        case biography
        case birthday
        case budget
        case cast
        case certifications
        case characterNames = "character_names"
        case createdBy = "created_by"
        case crew
        case deathday
        case episode
        case episodeNumber = "episode_number"
        case episodeRunTime = "episode_run_time"
        case freebaseID = "freebase_id"
        case freebaseMid = "freebase_mid"
        case general
        case genres
        case guestStars = "guest_stars"
        case homepage
        case images
        case imdbID = "imdb_id"
        case languages
        case name
        case network
        case originCountry = "origin_country"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case overview
        case parts
        case placeOfBirth = "place_of_birth"
        case plotKeywords = "plot_keywords"
        case productionCode = "production_code"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releases
        case revenue
        case runtime
        case season
        case seasonNumber = "season_number"
        case seasonRegular = "season_regular"
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case translations
        case tvdbID = "tvdb_id"
        case tvrageID = "tvrage_id"
        case type
        case video
        case videos
    }
}
