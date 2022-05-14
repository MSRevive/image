# MSRebirth Docker Image
This is the official Docker image to run a MSRebirth server. Currently this image only supports ``linux/amd64``, the chances of us adding Windows support is slim because none of us run Docker on Windows.

## Instructions
* Create a empty directory where ever you want your server files to be. For example we will use ``~/msrebirth/``
* Since we are still in beta you need to create a environment file with your Steam account credentials. For example we would create a file called ``env.list`` in the home directory with
```
STEAM_USER='username'
STEAM_PASS='password'
STEAM_AUTH='auth code'
```

## Usage
```
 $ docker run -d -v ~/msrebirth/:/server -p 27015/udp ghcr.io/msrevive/image:latest --env-file ~/env.list -insecure -game msrebirth -map edana +maxplayers 8 -port 27015 +exec crashed.cfg -strictportbind -norestart
```

### Syntax
``$0 [-insecure] [-game ] [-map ] [+maxplayers ] [-port ] [+exec ] [-strictportbind] [-norestart]``

Note: All parameters specified as passed through to the server including any not listed.