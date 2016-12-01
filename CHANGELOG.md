# Change Log

This changelog was started using [these conventions](http://keepachangelog.com/).

## [2.0.3] - 2016-12-1

### Changed

 * Updated to Dashing 1.1.1
 * Updated the example page styles

## [2.0.2] - 2016-11-22

### Added

 * Navigation modal
    * Allows easy navigation between views inside the modal
    * Update demo app to include navigation example

## [2.0.1] - 2016-10-11

### Changed

  * Updated to Dashing 1.0.7
  * Fixed hover state on close icon by adding ::before to the hover state of .modal-close
  * Changed bower.json to use dash-modal.js instead of min as it was complaining that minified files can't be used

## [2.0.0] - 2016-10-11

### Changed

  * Updated to Dashing and Dashing icons 1.0.0

## [1.5.1] - 2016-01-04

### Changed

  * added an option to prevent scrolling on close

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
