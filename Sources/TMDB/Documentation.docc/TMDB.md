# ``TMDB``

A Swift 6.2 wrapper around the TMDB API. Engineered for simplicity.

## Overview

Adding overview text here

## Topics

### Initialization

- <doc:Usage>
- ``TMDB``
- ``TMDBConfiguration``

### Supported Endpoints

- ``TMDB/movieDetails(id:)``
- ``TMDB/alternativeMovieTitles(id:)``
- ``TMDB/alternativeMovieTitles(movie:)``
- ``TMDB/apiConfigurationDetails()`` 
- ``TMDB/credits(forID:)``
- ``TMDB/credits(forMovie:)``
- ``TMDB/discoverMovie()``
- ``TMDB/discoverMovie(filters:)``
- ``TMDB/discoverTV()``
- ``TMDB/discoverTV(filters:)``
- ``TMDB/supportedCountries()`` 

### Errors

- ``TMDBAPIError``
- ``TMDBInitializationError``
- ``TMDBRequestError``

### Codable Property Wrappers

- ``ISO8601YMD``
- ``LanguageArray``
- ``LanguageCode``
- ``Minutes``
- ``NilBoolean``
- ``NilCodableArray``
- ``NilInteger``
- ``RegionArray``
- ``RegionCode``

### API Responses (Structs)

- ``TMDB/AlternativeTitle``
- ``TMDB/ImageConfiguration``
- ``TMDB/ConfigurationResponse``
- ``TMDB/Credits/Details``
- ``TMDB/Discover/DiscoverMovie``
- ``TMDB/Discover/DiscoverTV``
- ``TMDB/Discover/PaginatedResponse``
- ``TMDB/Genre``
- ``TMDB/Movie``
- ``TMDB/ProductionCompany``
- ``TMDB/TitleCollection``

### API Responses (Enums)

- ``TMDB/Configuration/ChangeKey``
- ``TMDB/Configuration/ImageSize``

### Discover Filters

- ``TMDB/Discover/MovieFilter``
- ``TMDB/Discover/TVFilter``

### Format Styles

- ``Runtime``
