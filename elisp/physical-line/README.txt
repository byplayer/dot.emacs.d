physical-line.el
  Minor mode for point motion in physical lines.

  Copyright (c) 2000-2002,2007 KAMADA Ken'ichi
  All rights reserved.


Features
========
  * Vertical cursor move in physical (screen) lines.

  This is all...



Supported Environments
======================
  * Mule 2.3 (GNU Emacs 19.34)
  * GNU Emacs 20
  * GNU Emacs 21
  * GNU Emacs 22

  physical-line version 3.2 was tested on
  * GNU Emacs 22.1

  physical-line version 3.0 was tested on
  * Mule 2.3 (GNU Emacs 19.34)
  * GNU Emacs 21.2



Installation
============
  (1) Put physical-line.el into a directory in your load-path.
  (2) Add
      (require 'physical-line)
      in your configuration file. (e.g. ~/.emacs)



Usage
=====
     M-x physical-line-mode toggles physical-line minor mode.
  In this mode, the cursor moves vertically in physical (screen)
  lines.

     physical-line functions are called from advice to `next-line'
  and `previous-line'.  These advice calls physical-line
  functions only when they are called interactively.  If you want
  to use advised functions with some commands, specify them in
  `physical-line-active-command-list'.

  User functions
    physical-line-mode
    physical-line-next-line
    physical-line-previous-line
    physical-line-beginning-of-line
    physical-line-end-of-line

  Variables
    physical-line-slip-backward
    physical-line-mode-string
    physical-line-mode-load-hook
    physical-line-active-command-list



Example of .emacs
=================
  (require 'physical-line)
  (define-key global-map "\C-c\C-l" 'physical-line-mode)



More Examples
=============
  ;; If you like the point to go before multi-column character,
  (setq physical-line-slip-backward t)

  ;; If you want to use physical-line-mode by default, do
  (setq-default physical-line-mode t)



Bugs
====
  If you can read Japanese, see bugs/Bugs.ja.txt.



Copyright and License
=====================
  Copyright (c) 2000-2002,2007 KAMADA Ken'ichi
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions
  are met:
  1. Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
  2. Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in the
     documentation and/or other materials provided with the distribution.

  THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
  OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  SUCH DAMAGE.
