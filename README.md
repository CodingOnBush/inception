The --no-install-recommends and --no-install-suggests flags are used to avoid installing unnecessary packages.\
I used the the commands with && to avoid creating unnecessary layers.\
The rm -rf /var/lib/apt/lists/* is used to clean the apt cache and avoid unnecessary files in the image.\