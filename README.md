# Description
Easy to use OWASP Dependency-Check Docker Image with always up to date Vulnerability Database.
# Usage
Just specify an input folder, with the libraries you want to scan, and an output folder where you would like
to receive the reports. 

The command below mounts the current path as input as well as output, but you can choose other folders as well.

`docker run --volume $(pwd):/input --volume $(pwd):/output mainmethod/dependency-check`

Note: If you get `[ERROR] Error generating the report for` the output folder is not writable. Please create
the output folder with correct permissions before starting this container.  