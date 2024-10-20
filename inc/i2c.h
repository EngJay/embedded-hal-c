/**
 * @file i2c.h
 * @brief Embedded HAL I2C interface.
 *
 * @author Jason Scott <reachme@jasonpscott.com>
 * @date 2024-09-03
 *
 * @copyright Copyright (c) 2024
 */
#ifndef EMBEDDED_HAL_C_INC_I2C_H
#define EMBEDDED_HAL_C_INC_I2C_H

#include <stdint.h>

// Types.
typedef uint8_t EHC_I2C_seven_bit_address;
typedef uint16_t EHC_I2C_ten_bit_address;

typedef struct EHC_I2C EHC_I2C;

typedef enum
{
    Ok = 0,
    I2cErrorBus,
    I2cArbitrationLoss,
    I2cNoAcknowledgement,
    I2cOverrun,
    I2cOther,
    NullPointer
} EHC_I2C_ReturnCode;

    // Buffer to receive to.
    //
    // - Write / read until the end of the buffer automatically to avoid having
    //   multiple functions for reading and writing.

    //

    // blocking

    // non-blocking

    // Address mode: 7 or 10 bits.

    // Init

    // Read

    // Write

    // WriteRead

    // RunTransaction

#endif // End include guard.
