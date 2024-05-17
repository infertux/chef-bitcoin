[GitHub Actions](https://github.com/infertux/chef-bitcoin/actions) is used to test a matrix of configurations.

You can also run a build locally for a specific configuration, e.g.:

`KITCHEN_PLATFORM=debian KITCHEN_RECIPE=binary KITCHEN_VARIANT=core bundle exec rake`
