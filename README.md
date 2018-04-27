# PRTG-Miltiple-SSL-Cert-Day-Until-Expiration
PRTG Advanced XML Sensor to get the Days left for SSL Certs by domain

For installation have a look at [PRTG Manual] (https://www.paessler.com/manuals/prtg/exe_script_advanced_sensor)

This script was created to have an overview of all Let's Encrypt SSL Certs on our web server. Therefore, the limits are set as followed:
- LimitMinWarning = 20
- LimitMinError = 10

You have to insert the domains to check into the parameters field (comma seperated)
```
google.com,heise.de
```