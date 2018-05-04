# sh_cleaner.sh

Erase the current shell history, cleans cache memory, dentries, inodes and swap.

## Usage

```
$ bash -i sh_cleaner.sh
```

Or

```
$ ./sh_cleaner.sh
```

Note: The script if the script is run like the first option, it has to be using the interactive switch,
this is so the script can read the *$HISTFILE*, which is not-present in an non-interactive shell
(Like the one on a normal bash script).
