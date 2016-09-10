# github2cgit

Just something to help generate the information required by [cgit][0] to
display your repository.  Please remember to include the repository file in
your `/etc/cgitrc`.

Here is a real example:

    css=/cgit.css
    logo=/cgit.png
        virtual-root=/
        include=/etc/github_repositories
    enable-git-clone=1
    enable-http-clone=1
    snapshots=tar.gz tar.bz2 zip
    enable-index-links=1
    enable-commit-graph=1
    enable-log-filecount=1
    enable-log-linecount=1

## TODO

- [ ] Support private repsitories.
- [ ] Support public and private organizations.
- [ ] Use external configuration files for users and organizations.

[0]: http://git.zx2c4.com/cgit/
