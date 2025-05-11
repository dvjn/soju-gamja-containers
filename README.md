# soju-gamja-containers

Container manifests for [soju] and [gamja].


## Docker images

### [`github.com/dvjn/soju`][soju-img]

This image starts a soju instance reading its configuration from `/soju-config`.

### [`github.com/dvjn/gamja`][gamja-img]

This image serves the gamja webapp on port 80. By default, gamja will connect
to `ws://gamja-backend/socket`. The gamja configuration file can be customized
by mounting `/gamja-config.json`.

[soju]: https://codeberg.org/emersion/soju
[gamja]: https://codeberg.org/emersion/gamja
[soju-img]: https://github.com/dvjn/soju-containers/pkgs/container/soju
[gamja-img]: https://github.com/dvjn/soju-containers/pkgs/container/gamja
