# Homebrew GoldenEye Tracert

Homebrew tap for [goldeneye-tracert](https://github.com/LarssonOskar/goldeneye-tracert) —
a real traceroute visualized as the satellite-uplink terminal from *GoldenEye*.

## Install

Homebrew 7 requires third-party taps to be trusted explicitly:

```sh
brew tap LarssonOskar/goldeneye
brew trust LarssonOskar/goldeneye
brew install goldeneye-tracert
```

Then run:

```sh
goldeneye-tracert --demo
goldeneye-tracert 8.8.8.8
```

## Upgrade

```sh
brew update
brew upgrade goldeneye-tracert
```

## Development

Install the current `main` branch:

```sh
brew install --HEAD LarssonOskar/goldeneye/goldeneye-tracert
```

The formula lives in [`Formula/goldeneye-tracert.rb`](Formula/goldeneye-tracert.rb).
