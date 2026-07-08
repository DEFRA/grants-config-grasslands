# grants-config-grasslands

Configuration for grasslands grant journeys served through the grants configuration release process.

## Language

**Grasslands**
The grant family represented by `configurations/grasslands`.
_Avoid_: Generic land grant when the grasslands configuration is meant

**Grant configuration**
A versioned set of files that describes a grant journey and related integration metadata.
_Avoid_: Form code, Runtime state, Test script

**Grant journey**
The end-to-end user flow rendered from the grasslands configuration.
_Avoid_: Wizard, Survey, Funnel

**Grants UI config**
Configuration consumed by Grants UI to render pages, components, validation, and navigation.
_Avoid_: GAS config, Source code, Test data

**Version**
The release version of the configuration package.
_Avoid_: Build number, Commit SHA, Application status

**Changeset**
The release note/version marker required for configuration changes.
_Avoid_: Changelog entry when the `.changeset` file is meant, Commit message

**Hotfix release**
A patch release from a tagged version used only when the normal release path cannot deliver the fix.
_Avoid_: Regular release, Feature branch, Rollback
