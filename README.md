# langtool-ignore-fonts
[![MELPA](https://melpa.org/packages/langtool-ignore-fonts-badge.svg)](https://melpa.org/#/langtool-ignore-fonts)

Force [Langtool](https://github.com/languagetool-org/languagetool) to
ignore certain fonts. For example, stop Langtool from highlighting LaTeX in math-mode.

## Summary

When running [Emacs-Langtool](https://github.com/mhayashi1120/Emacs-langtool) on a
buffer containing a markup language, Langtool will highlight many false
positives. This is especially true for documents written in LaTeX.

This package solves this problem by allowing one to leverage the power
of their given major-mode's syntax highlighting to ignore a certain
font. The idea here is that the major-mode should have put in a lot of
thought about identifying the various parts of the document.

For example, by telling Langtool to ignore `font-latex-math-face` it will no
longer complain about math expressions. This was my main use case
while writing my thesis. This effectively adds langtool support for
LaTeX in Emacs. To set which fonts to ignore for a specific major-mode
one calls the provided function `langtool-ignore-fonts-add`. For
example, this package provides out of the box support for LaTeX as
follows:

```
(langtool-ignore-fonts-add 'latex-mode  '(font-lock-comment-face
					  font-latex-math-face font-latex-string-face))
```

This is an example of what Langtool highlights in LaTeX-mode before this
package is installed:

<img src="https://imgur.com/puxKwB3.jpg" alt="Picture of some LaTeX without this package." width="600">

This is what Langtool highlights instead with this package installed:

<img src="https://imgur.com/Gmpu7xU.jpg" alt="Picture of some LaTeX with this package." width="600">

However, I can see this being used for many other major-modes. For
example, to set markdown-mode to ignore code blocks add the
following to your init file after loading this package.

```
(langtool-ignore-fonts-add 'markdown-mode '(markdown-code-face))
```
Now, there is a minor-mode `langtool-ignore-fonts-minor-mode` so that
this package only modifies the behavior of langtool when this
minor-mode is enabled.

Note: This package works in two passes. Langtool first highlights
everything like normal and then this package removes the forbidden
highlights.

## Installing from MELPA

This package may be obtained from [MELPA](https://melpa.org/#/langtool-ignore-fonts). 

You can use use-package. Here is a minimal configuration for LaTeX:
```
(use-package langtool-ignore-fonts
  :config
  (add-hook 'LaTeX-mode-hook 'langtool-ignore-fonts-minor-mode))
```
You can configure which other fonts to ignore here. For example, here is a configuration for Markdown mode: 
```
(use-package langtool-ignore-fonts
  :config 
  (add-hook 'LaTeX-mode-hook 'langtool-ignore-fonts-minor-mode)
  (add-hook 'markdown-mode-hook 'langtool-ignore-fonts-minor-mode)
  (langtool-ignore-fonts-add 'markdown-mode '(markdown-code-face)))
```

## Contributing

Yes, please do! Make a pull-request.

## License

See [COPYING][]. Copyright (c) 2021 Christopher Lloyd.


[CONTRIBUTING]: ./CONTRIBUTING.md
[COPYING]: ./COPYING
