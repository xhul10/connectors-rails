# Releasing the Connectors project

The Connectors project contains logic that is also packaged as a Gem to be included in the Enterprise Search distribution ([example](https://github.com/elastic/ent-search/blob/9e87bf1c293df97f3a550ed1e2a7efac18c9d8f2/Gemfile#L262)).

The version scheme we use is **MAJOR.MINOR.PATCH.BUILD** and stored in the [VERSION](https://github.com/elastic/connectors/blob/main/VERSION) file
at the root of this repository.

## RubyGem Account

When releasing Gems, you will be asked for an Email and Password.
Look into the Vault in the `ent-search-team/rubygem` secret.

## Unified release

**MAJOR.MINOR.PATCH** should match the Elastic and Enterprise Search version it targets 
and the *BUILD* number should be set to **0** the day the Connectors release is created
to be included with the Enterprise Search distribution.

For example, when shipping for `8.1.2`, the version is `8.1.2.0`.

To release Connectors:

- Set the VERSION file to the new/incremented version on the release branch
- Make sure all tests and linter pass with `make lint test`
- PR these changes to the appropriate Connectors release branch
- Run `make release`

A Gem will be published to RubyGems: https://rubygems.org/gems/connectors_sdk.

Then immediately update ent-search's gem dependency with the released version:

- Update Gemfile if necessary
- Run `./script/bundle update connectors_sdk`
- Verify bundler picked up the version you expected it to update to
- PR these changes to the appropriate Enterprise Search release branch ([example](https://github.com/elastic/ent-search/pull/6476))

Last, take care of the branching:

- Increment the VERSION on main to match the next release
- Create a new maintenance branch if it's a new MINOR

After the Elastic unified release is complete

- Update the **BUILD** version ([example PR](https://github.com/elastic/connectors/pull/81)). Note that the Connectors project does not immediately bump to the next **PATCH** version. That wont happen until that patch release's FF date.

## In-Between releases

Sometimes, we need to release Connectors independantly from Enterprise Search.
For instance, if someone wants to use the project as an HTTP Service and we have a
bug fix we want them to have as soon as possible.

In that case, we increment the **BUILD** number, and follow the same release
process than for the unified release, except that this gem won't ship with Enterprise Search.

So `8.1.2.1`, `8.1.2.2` etc. On the next unified release, the version will be bumped to
the next **PATCH** value, and **BUILD** set to `0`

**In-Between releases should never introduce new features since they will eventually be
merged into the next PATCH release. New features are always done in Developer previews**

## Developer preview releases

For developer previews, we are adding a `pre` tag using an ISO8601 date.
You can use `make release_dev` instead of `make release` in that case.
