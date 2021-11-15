# Packrat

[Packrat](https://packrat.lol) is a way for NFT owners to stay up to date on their favorite projects without having to sift through the noise of Discord announcements.

Never miss another mint, airdrop, collaboration, event or any other significant moment in the life of an NFT project!

## Setup

You'll need:

- ruby >3 (specific version is in `Gemfile`)
- postgreql (if using stock `config/database.yml`)

```shell
cd packrat
bundle install
rails db:setup
```

You can then run the rails web server:

```shell
rails server
```

And visit [https://localhost:3000](https://localhost:3000)

## Contributing

It's still very early days for this so your mileage will vary here and lots of things will break.

But almost any contribution will be beneficial at this point. Check the [current Issues](https://github.com/Shpigford/packrat/issues) to see where you can jump in!

If you've got an improvement, just send in a pull request!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

If you've got feature ideas, simply [open a new issues](https://github.com/Shpigford/packrat/issues/new)!

## License & Copyright

Released under the MIT license, see the [LICENSE](https://github.com/Shpigford/packrat/blob/main/LICENSE) file. Copyright (c) Sabotage Media LLC.
