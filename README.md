# Biometric Systems Project

[![CodeFactor](https://www.codefactor.io/repository/github/casalinovalerio/biosys-project/badge)](https://www.codefactor.io/repository/github/casalinovalerio/biosys-project)

## Members

- Shaahin (@)
- Tobi (@TobMTV)
- Valerio (@casalinovalerio)

## Introduction

This is a very interesting introduction.

## Steps to reproduce

Clone the repo in your db-server, api-server and on the pc where you want to work on the website:

```bash
git clone "https://github.com/casalinovalerio/biosys-project.git"
```

On db-server:

```bash
# You'll need Docker installed
./install.sh db
```

On api-server:

```bash
# Default is /var/www/html
./install.sh api -d /path/to/webroot
```

On your pc:

```bash
# Both args are optional, if no arg is supplied it will print the usage
./install.sh pc -w /path/to/web-devel-folder -t /path/to/presentation/folder
```

## TODOs

- [ ] Put the (web: html + css + js) login interface in `docs` folder.
- [x] Put Docker files to replicate the configuration in `database` folder.
- [ ] Put the presentation in `presentation` folder.
- [ ] Put php files for api server in `api` folder.
- [ ] Write scripts to reproduce our exact same setup.
- [ ] Update the README.
- [ ] Divide the work between members.
