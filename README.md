# langtool-ignore-fonts

## Summary

Force [langtool](https://github.com/languagetool-org/languagetool) to
ignore certain fonts. For example don't highlight LaTeX in math-mode.

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

However, I can see this being used for many other major-modes. For
instance to set markdown-mode to ignore code comments add the
following to your init file after loading this package.

```
(add-hook 'markdown-mode-hook (lambda () 
	(setq langtool-ignore-fonts '(markdown-code-face))))
```

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

See [COPYING][]. Copyright (c) 2021 Chrstopher Lloyd.


[CONTRIBUTING]: ./CONTRIBUTING.md
[COPYING]: ./COPYING
