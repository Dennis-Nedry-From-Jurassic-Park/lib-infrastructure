https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

#!/bin/bash
set -Eeuo pipefail

trap "echo ERR trap fired!" ERR
```shell
myfunc()
{
    foo # 'foo' is a non-existing command
}
```


myfunc
echo "bar"

# output
# ------
# line 9: foo: command not found
# ERR trap fired!
#
# Not only do we still have an immediate exit, we can also clearly see that the
# ERR trap was actually fired now.