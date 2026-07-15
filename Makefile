# --- Flutter Commands ---
# Update project dependencies
pub-get:
	flutter pub get

# Clean project and update dependencies
clean-build:
	flutter clean
	flutter pub get

# --- Code Generation Commands ---
# Run code generation once
gen:
	dart run build_runner build --delete-conflicting-outputs

# Run code generation in watch mode for active development
watch:
	dart run build_runner watch --delete-conflicting-outputs

# Clean generated files
gen-clean:
	dart run build_runner clean

# --- Testing Commands ---
# Run unit and widget tests
test:
	flutter test

# --- Maintenance Commands ---
# Perform a full project reset (clean flutter and build_runner caches)
full-clean:
	flutter clean
	dart run build_runner clean
	flutter pub get
