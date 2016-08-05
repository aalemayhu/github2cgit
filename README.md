# github2cgit

Just something to help generate the information required by [cgit][0] to display you repository.
All scripts generate their own files please remember to include them in your `/etc/cgitrc`.
You can easily include e.g. the repositories as following:

    css=/cgit.css
    logo=/cgit.png
        virtual-root=/
        include=/etc/github_repositories

[0]: http://git.zx2c4.com/cgit/
