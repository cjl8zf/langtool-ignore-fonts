# langtool-ignore-fonts

## Summary

Force [Langtool](https://github.com/languagetool-org/languagetool) to
ignore certain fonts. For example, stop Langtool from highlighting LaTeX in math-mode.

When running [Emacs-Langtool](https://github.com/mhayashi1120/Emacs-langtool) on a
buffer containing a markup language Langtool will highlight many false
positives. This is especially true for documents written in LaTeX.

This package solves this problem by allowing one to leverage the power
of their given major-mode's syntax highlighting to ignore a certain
font. The idea here is that the major mode should have put in a lot of
thought to identifying the various parts of the document.

For instance by telling Langtool to ignore 'font-latex-math-face
Langtool will no longer complain about math expressions. This was my
main use case while writing my thesis. This effectively adds langtool
support for LaTeX in Emacs. One simpliy adds a hook for their desired
mode and sets the list `'langtool-ignore-fonts` to the desired list of
ignored fonts. We provide out of the box support for LaTeX as follows:

```
(add-hook 'latex-mode-hook (lambda () 
	(setq langtool-ignore-fonts '(font-lock-comment-face font-latex-math-face))))
```

This is an example of what Langtool highlights in LaTeX-mode before this
package is installed:

![](https://imgur.com/XuLEsV8.jpg)

This is what Langtool highlights with this package installed:

![](https://imgur.com/DJtTS5k.jpg)

However, I can see this being used for many other major-modes. For
instance to set markdown-mode to ignore code blocks add the
following to your init file after loading this package.

```
(add-hook 'markdown-mode-hook (lambda () 
	(setq langtool-ignore-fonts '(markdown-code-face))))
```

Note: This package works in two passes. First Langtool highlights
everything like normal, and then this package removes the forbidden
highlights.

## Installing

You will need Emacs 24+, `make` and [Cask](https://github.com/cask/cask) to
build the project.

    cd langtool-ignore-fonts
    make && make install

This should install the package to your elpa folder. Then import:

```
(require 'langtool-ignore-fonts "~/.emacs.d/elpa/langtool-ignore-fonts")
```

Or you can use use-package (once you have installed it locally): 
```
(use-package langtool-ignore-fonts
  :load-path "~/.emacs.d/elpa/")
```
You could add your markdown font list here for instance 
```
(use-package langtool-ignore-fonts
  :load-path "~/.emacs.d/elpa/"
  :config 
  (add-hook 'markdown-mode-hook (lambda () 
	(setq langtool-ignore-fonts '(markdown-code-face)))))
```
## Contributing

Yes, please do! See [CONTRIBUTING][] for guidelines.

## License

See [COPYING][]. Copyright (c) 2021 Christopher Lloyd.


[CONTRIBUTING]: ./CONTRIBUTING.md
[COPYING]: ./COPYING
