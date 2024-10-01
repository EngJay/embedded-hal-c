# I2C Example: BME280 - TI F28379D Launchpad

An embedded-hal-c example of I2C communications with a BME280 sensor and TI
F28379D Launchpad dev board.

## Building

Due to the incompatibility of the TI C28x compilers with Meson, this example
project uses a Meson build configuration to pull in the dependences but still
depends on Make and Makefile to build the project.

Two steps are needed to build the project

Step 1: Configure the Meson build using the Makefile shim.

```bash
CROSS=c2000 make -f Makefile.shim
```

Step 2: Run the Make build.

```bash
make CROSS=ti:lp-f28379d:bare-metal:c2000:c99
```

## Running the tests

- The tests are built natively with `gcc-14` and run off-target, so `gcc-14`
  must be installed on the machine or in the container running them.

The tests are run by running the `test` target of the Makefile shim.

```bash
make -f Makefile.shim test
```
