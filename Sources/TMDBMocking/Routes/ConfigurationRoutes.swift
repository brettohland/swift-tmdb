import Foundation
import TMDB

enum ConfigurationRoutes: MockRouteProvider {
    static var mockRoutes: [MockRoute] {
        [
            MockRoute(pattern: "^/3/configuration$") {
                try TMDB.ConfigurationResponse.mockData()
            },
            MockRoute(pattern: "^/3/configuration/countries$") {
                try MockUtilities.jsonDataFromFile("Countries")
            },
            MockRoute(pattern: "^/3/configuration/jobs$") {
                try TMDB.Configuration.JobDepartment.mockData()
            },
            MockRoute(pattern: "^/3/configuration/languages$") {
                try TMDB.Configuration.Language.mockData()
            },
            MockRoute(pattern: "^/3/configuration/primary_translations$") {
                try MockUtilities.jsonDataFromFile("PrimaryTranslations")
            },
            MockRoute(pattern: "^/3/configuration/timezones$") {
                try TMDB.Configuration.Timezone.mockData()
            },
        ]
    }
}
