# I2C Example: BME280 - TI F28379D Launchpad

An embedded-hal-c example of I2C communications with a BME280 sensor and TI
F28379D Launchpad dev board.

## Building

Due to the incompatibility of the TI C28x compilers with Meson, this example
project uses a Meson build configuration to pull in the dependences but still
depends on Make and an adapter Makefile to build the project. The Makefile,
`Makefile.adapter`, is run from the Meson build, so the standard Makefile shim
is still used to run the build.

```bash
make CROSS=c2000
```

## Running the tests

- NOTE: The tests are built natively with `gcc-11` and run off-target, so
  `gcc-11` must in the path on the machine or in the container running them.

The tests are run by running the `test` target of the Makefile shim.

```bash
make test
```

### Test Coverage

To generate test coverage reports, the Pip package `gcovr` must be available on
the machine running the tests.

A script has been included in the root of the project for *nix machines,
`setup-coverage-reporting.sh`.

Then, the coverage reports can be generated through Meson via the
`test-coverage` target in the Makefile shim.

```bash
make test-coverage
```
