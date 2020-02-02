# Testing

## Get the gallery

In the `scraper` folder there are some scripts to scrape image from Getty images. Choose `/testing/gitignore` as download location, to keep them untracked from git.

To download a person set of images go to [Getty images](https://www.gettyimages.it/editorial-images) look for the person and copy the link to his/her page, then use that link to download the images from that page as:

```bash
/testing/scraper/scrape-and-download <url> <name> <img-dir>
```

Do this as many time as you want, but be sure to choose always the same folder for the same person. To upload the files to train the service:

```bash
/testing/upload-person-gallery <img-dir> <server-url> <name/person-id>
```

## Get probes

As probes, we got 10 random pictures of every person in the gallery, plus some more people, by using the scrape-and-download script.