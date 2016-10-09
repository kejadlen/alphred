## [Unreleased]
### Fixed
- Don't fail when there aren't environment vars to clean

## [2.0.1] - 2016-07-28
### Fixed
- Rake task now cleans `Don't Export`-ed environment vars.

## [2.0.0] - 2016-05-15
### Added
- `Alphred::Items[...]` convenience method.

### Changed
- `to_xml` has been deprecated in favor of `to_json`.
- `mods` in an `Alphred::Item` are declared differently now.

### Removed
- `Alphred::Config` has been deprecated since Alfred 3 supports environment
variables.

## [1.2.2] - 2016-04-17
### Fixed
- Require FileUtils for Config.
- Require version arg for the Rake tag task.

## [1.2.1] - 2016-04-05
### Fixed
- Handle when config doesn't already exist.

## [1.2.0] - 2016-04-04
### Added
- Push tags when releasing.
- Add better error handling.

## [1.1.1] - 2015-11-05
### Changed
- Don't crash when the config file doesn't exist.

## [1.1.0] - 2015-11-01
### Added
- `Config` class for handling persistent configuration across workflow updates.
- CHANGELOG

## [1.0.0] - 2015-10-31
### Added
- Library for making Alfred workflows.
