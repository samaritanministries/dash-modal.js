# Change Log

This changelog was started using [these conventions](http://keepachangelog.com/).

## [1.2.0] - 2015-10-07

### Changed

 * Do not re-render a view that is already rendered

## [1.1.1] - 2015-09-21

  * Updated $modal-gutter structure
  * Added <hr> specific styles

## [1.1.0] - 2015-09-03

### Added

  * New Modal Structure. It is now required that all content within a modal use a specific structure:
    1. For the title of a modal, include `<div class="modal-header"></div>`
    2. For modal content, use `<div class="modal-content"></div>`
    2. For the modal footer, use `<div class="modal-footer"></div>`

## [1.0.0] - 2015-04-23

### Added

  * `hasXButton` option to DashModal.View
  * `shouldCloseOnOverlay` option to DashModal.View

### Removed

  * `shouldAllowClose` option to DashModal.View

## [0.1.0] - 2015-03-11

### Added

 * `shouldCloseOnEscape` option to DashModal.View
