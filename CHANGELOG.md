# ChangeLog

This document shows the changes per release

## Current Head

  * Improvements to HomeAssistant EMS module to avoid setting Consumption/Generation values to zero as a result of a connection failure, and better exception handling in general for the module.

## v1.0.1 - 2019-10-06

This release is a bugfix release for v1.0.0. It contains the following fixes:

  * Fixed: MQTT status connection timeout causes a delay to heartbeat timers, which then cause TWCManager reconnections to Slaves
  * Fixed: MQTT and HASS status update rates are too high. All updates now rate limited to one per minute.
  * Fixed: Strange behaviour related to default generation tracking hour (-1). Changed this to a more sane value (8am) in the code, with a view to fixing this entire logic for the next major release (v1.1.0).

## v1.0.0 - 2019-10-05

This module provides HomeAssistant sensor functionality to the TWCManager project. It is the first release after the fork and restructuring of the code and configuration files.

### New Features

  * Forked original repository by cdragon
  * Integrated multi-charger and multi-car MQTT integration (Status Module) from flodorn's repository
  * Split the Sensor (EMS) and Status functions out of the main script
  * Created HomeAssistant EMS and Status modules and tested successfully
  
### Known Issues

  * No MQTT authentication is available currently. This will be fixed in an upcoming patch (v1.0.2).
  * Large numbers of uncaught exceptions around connectivity for EMS and Status interfaces - These can be safely ignored, they will be fixed in v1.1. Currently, they will only result in excessive logging.
  * Charger consumption is counted in the consumption reading in some environments. If this is the case in your setup, the consumption rise as a result of the charger utilization will cause the available generation value to fall, continually disabling charging.
    * This will be fixed in an upcoming patch (v1.0.2)
    * In the meantime, it is recommended that you disable the consumption sensor. This will charge based on generation values but will not account for consumption.
