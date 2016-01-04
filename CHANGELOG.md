# Change Log

This changelog was started using [these conventions](http://keepachangelog.com/).

## [1.5.1] - 2016-01-04

### Changed

 * When showing a modal, set the focus on that modal.
   This way, the user should be able to see it even if it appears off screen,
   which is what happens within iframes on iOS devices.

## [1.5.0] - 2015-11-18

### Changed

 * dist/dash-modal.scss no longer depends on dashing-core

## [1.4.0] - 2015-11-04

### Added

 * Added triggers `showModalComplete` on the passed in view when it is completely visible

## [1.3.1] - 2015-10-28

### Added

 * Added ~ to accept patch level changes of dashing-core

## [1.2.1] - 2015-10-07

### Added

 * Allow a modal to be shown a second time

### Removed

 * Remove 150ms timeout while hiding.

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
