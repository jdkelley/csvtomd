# [WIP] - csvtomd

This tool converts a CSV table into a markdown formatted table.

## Usage

Currently, this will work by runnig `./csvtomd.sh <path to csv file>`

At the moment format of the csv file should be like in [`example/test.csv`][test_csv].

## In Docker

`csvtomd` is available in a Docker container on [dockerhub][dockerhub].

There is a catch using the tool this way-you need copy the csv file into a directory named `workdir` in your current directory. I use this by running `docker run -v workdir:/script jdkelley/csvtomd fileToConvert.csv`.

## License

This tool is released under the [MIT License][license].

[test_csv]: ./example/test.csv "Example CSV Format"
[license]: ./LICENSE "MIT License"
[dockerhub]: https://hub.docker.com/r/jdkelley/csvtomd "jdkelley/csvtomd"

