Logparty
========

[![Build Status](https://travis-ci.org/elentok/logparty.png?branch=master)](https://travis-ci.org/elentok/logparty)

Cleans up [httparty](https://github.com/jnunemaker/httparty) logs.

Installation
=============

```bash
npm install -g logparty
```

Usage
=====

```bash

tail -f log/httparty.log | logparty

# to limit the amount of lines of request bodies:
tail -f log/httparty.log | logparty -l 10

```
