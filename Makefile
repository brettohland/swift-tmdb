.PHONY: test integration-test docs preview-docs format

test:
	swift test --filter TMDBTests

integration-test:
	swift test --filter TMDBIntegrationTests

docs:
	swift package --allow-writing-to-directory ./docs \
		generate-documentation --target TMDB \
		--disable-indexing \
		--transform-for-static-hosting \
		--hosting-base-path swift-tmdb \
		--output-path ./docs

preview-docs:
	swift package --disable-sandbox preview-documentation --target TMDB

format:
	swiftformat --exclude docs Sources Tests
