bash-semver
===========

Increment semantic versioning strings in shell scripts.

```shell
$ ./increment_version.sh
usage: increment_version.sh [-Mmp] major.minor.patch

$ ./increment_version.sh -p 0.0.0
0.0.1

$ ./increment_version.sh -m 0.0.3
0.1.0

$ ./increment_version.sh -M 1.1.15
2.0.0

$ ./increment_version.sh -Mmp 2.3.4
3.1.1

$ ./increment_version.sh -r 1.1.2
1.1.2-rc.0

$ ./increment_version.sh -r 1.1.2-rc.0
1.1.2-rc.1

$ ./increment_version.sh -R 1.1.2-rc.0
1.1.2

$ ./increment_version.sh -d 1.1.2
1.1.2-dev
```
