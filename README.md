# Xinjiang's dotfiles

The dotfiles are based on paulirish (https://github.com/paulirish/dotfiles/)

## Shell Demo
[![asciicast](https://asciinema.org/a/31004.png)](https://asciinema.org/a/31004)

## Tools I use

- Sublime Text 3
- HomeBrew
- Zsh
- iTerm2

## Sublime Text Packages

### install package control for sublime text 3
View > Show Console

```
import urllib.request,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```

### install other packages via Package Control

- AdvancedNewFile
- SublimeLinter
- Markdown Preview
- SFTP
- Dotfiles Syntax Highlighting
- SublimeLinter-jscs



