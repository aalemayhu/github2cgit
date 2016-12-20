# github2cgit

Just something to help generate the information required by [cgit][0] to
display your repository.  Please remember to include the repository file in
your `/etc/cgitrc`.

Here is a real example:

    include=/etc/github_repositories
    virtual-root=/
    css=/cgit.css
    enable-commit-graph=1
    enable-git-clone=1
    enable-git-config=1
    enable-html-serving=1
    enable-http-clone=1
    enable-index-links=1
    enable-index-owner=1
    enable-log-filecount=1
    enable-log-linecount=1
    logo=/cgit.png
    root-readme=/var/www/html/about.html
    snapshots=tar.gz tar.bz2 zip

## TODO

- [ ] Support private repsitories.
- [ ] Support public and private organizations.
- [ ] Use external configuration files for users and organizations.

[0]: http://git.zx2c4.com/cgit/
