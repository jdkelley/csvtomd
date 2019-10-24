# [WIP] - csvtomd

This tool converts a CSV table into a markdown formatted table.

## Usage

After installing, this will work by running `csvtomd <path to csv file>`

At the moment format of the csv file should be like in [`example/test.csv`][test_csv].

## Install

Clone down the repository and install with:

```sh
./csvtomd.sh install
```

After this, the command `csvtomd` will be in your path and you can use it as `csvtomd example/test.csv`.

## Uninstall

To uninstall, run

```sh
csvtomd uninstall
```

## In Docker

`csvtomd` is available in a Docker container on [dockerhub][dockerhub].

There is a catch using the tool this way-you need copy the csv file into a directory named `workdir` in your current directory. I use this by running `docker run -v workdir:/script jdkelley/csvtomd fileToConvert.csv`.

## License

This tool is released under the [MIT License][license].

[test_csv]: ./example/test.csv "Example CSV Format"
[license]: ./LICENSE "MIT License"
[dockerhub]: https://hub.docker.com/r/jdkelley/csvtomd "jdkelley/csvtomd"

