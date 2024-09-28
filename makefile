generate: 
	dart run build_runner build --delete-conflicting-outputs && flutter pub get

serve_fake: 
	cd fake_server; npx json-server --watch db.json

generate_clean_cache:
	dart run build_runner clean

just_example_how_to_add_env_vars_to_built_app:
	flutter build appbundle --flavor production -t lib/main_production.dart --dart-define-from-file=.env

tests:
	flutter test