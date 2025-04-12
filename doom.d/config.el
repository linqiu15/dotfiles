;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Lin Qiu"
      user-mail-address "qiulin@ihep.ac.cn")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-monokai-pro)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "/Users/qiulin/Nutstore Files/Nutstore/org")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! cnfonts
  :config
  (cnfonts-enable))
(setq lsp-julia-default-environment "~/.julia/environments/v1.11")
(setq python-shell-interpreter "ipython")
(setq +latex-viewers '(skim))
(setq reftex-default-bibliography "/Users/qiulin/Nutstore Files/Nutstore/org/ref.bib")
(add-hook 'LaTeX-mode-hook
          (lambda()
            (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
            (setq TeX-command-default "XeLaTeX")))

(add-hook 'LaTeX-mode-hook
          (lambda()
            (add-to-list 'TeX-command-list '("LuaLaTex" "%`lualatex%(mode)%' %t" TeX-run-TeX nil t))
            ))
(setq deft-directory "/Users/qiulin/Nutstore Files/Nutstore/org/notes")


;;org
(setq org-re-reveal-root "file:///Users/qiulin/.doom.d/misc/reveal.js")

(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
(setq org-latex-pdf-process '("latexmk -f -pdf -%latex -shell-escape -interaction=nonstopmode -output-directory=%o %f"))


(add-to-list 'load-path "/opt/homebrew/opt/mu/share/emacs/site-lisp/mu/mu4e")
;; 设置 mu4e 的路径

(setq mu4e-mu-binary "/opt/homebrew/bin/mu")
(use-package! org-mime
  :config
  (require 'mu4e)
  (require 'smtpmail)
  (require 'org-mu4e)

  ;; 配置 mu4e 作为 MUA 以及基本的邮件信息配置
  (setq mail-user-agent 'mu4e-user-agent)
  (setq user-full-name "Lin Qiu")
  (setq user-mail-address "qiulin@ihep.ac.cn")
  (setq mu4e-maildir "~/.Maildir")

  ;; 配置使用 offlieimap 收取邮件
  (setq
   mu4e-get-mail-command "offlineimap"   ;; 使用 offlineimap 获取邮件
   mu4e-update-interval 300)             ;; 每五分钟检查邮件并更新索引 (配置单位：秒)

  ;; 配置默认 smtp 服务以使用 smtpmail mode 发送 Email
  ;; SMTP 服务需要认证，我采用 ~/.authinfo 的方式提供认证信息。
  ;; 有关 SMTP 认证, 参阅 https://www.emacswiki.org/emacs/SmtpAuth
  (setq send-mail-function 'smtpmail-send-it
	message-send-mail-function 'smtpmail-send-it
	smtpmail-auth-credentials "~/.authinfo"
	smtpmail-stream-type  'starttls)

  ;; set default values about mu4e
  (setq
   ;; auto update maildir with isync and index it
   mu4e-update-interval 300
   ;; don't do a full cleanup check
   mu4e-index-cleanup nil
   ;; don't consider up-to-date dirs
   mu4e-index-lazy-check t
   ;; show images in message mode
   mu4e-view-show-images t
   ;; set the default download dir for attachment
   mu4e-attachment-dir "~/Downloads"
   ;; prefer html view
   mu4e-view-prefer-html t
   ;; don't save message to sent messages, gmail/imap takes care of this
   ;; (see the documentation for `mu4e-sent-messages-behavior' if you have
   ;; additional non-gmail addresses and want assign them different
   ;; behavior.)
   mu4e-sent-messages-behavior 'delete
   )

  ;; set default values for sending mails
  (setq
   ;; user agent when send mail
   mail-user-agent 'mu4e-user-agent
   ;; 设置邮件发送方法为 smtpmail
   message-send-mail-function 'smtpmail-send-it
   ;; 根据 from 邮件头使用正确的账户上下文发送 email.
   message-sendmail-envelope-from 'header
   ;; 设置邮箱认证加密方式
   smtpmail-stream-type 'ssl
   ;; don't keep message buffers around
   message-kill-buffer-on-exit t
   )

  ;; some information about me
  (setq
   user-full-name  "Lin Qiu"
   ;; set a mail address list using when reply a message
   mu4e-user-mail-address-list '("qiulin@ihep.ac.cn"
				 "qiulin15@mails.ucas.ac.cn")
   message-signature
   (concat
    "Best wishes,\n"
    "Lin Qiu")
   )
  (setq message-signature-file "~/.emacs.d/signature.txt")
  ;; (setq mu4e-compose-signature-auto-include t)
  (setq mu4e-contexts
	`( ,(make-mu4e-context
             :name "IHEP"
             :enter-func (lambda ()
                           (mu4e-message "Entering IHEP context")
                           ;; update index after switch context, otherwise the
                           ;; counting is not updated
                           (mu4e-update-index))
             :leave-func (lambda () (mu4e-message "Leaving IHEP context"))
             ;; we match based on the contact-fields of the message
             :match-func (lambda (msg)
                           (when msg
                             (string-match-p "qiulin@ihep.ac.cn" (mu4e-message-field msg :maildir))))

             :vars '((user-mail-address             . "qiulin@ihep.ac.cn")
                     (mu4e-sent-folder              . "/IHEP/Sent")
                     (mu4e-drafts-folder            . "/IHEP/Drafts")
                     (mu4e-trash-folder             . "/IHEP/Trash")
                     (mu4e-refile-folder            . "/IHEP/Refile")
                     (smtpmail-default-smtp-server  . "mail.ihep.ac.cn")
                     (smtpmail-smtp-server          . "mail.ihep.ac.cn")
                     (smtpmail-smtp-service         . 465)
                     (mu4e-get-mail-command         . "offlineimap")
                     (mu4e-maildir-shortcuts . (("/IHEP/INBOX"   . ?i)
						("/IHEP/Sent"    . ?s)
						("/IHEP/Refile"  . ?r)
						("/IHEP/Trash"   . ?t)
						("/IHEP/Drafts"  . ?d)))
                     (mu4e-bookmarks . ( ("maildir:/IHEP/INBOX AND flag:unread AND NOT flag:trashed"   "Unread messages"        ?u)
					 ("maildir:/IHEP/INBOX AND date:today..now"                    "Today's messages"       ?t)
					 ("maildir:/IHEP/INBOX AND date:7d..now"                       "Last 7 days"            ?w)
					 ("maildir:/IHEP/INBOX AND date:1d..now"                       "Last 1 days"            ?o)
					 ("maildir:/IHEP/INBOX"                                        "Inbox"                  ?i)
					 ("maildir:/IHEP/Sent"                                         "Sent"                   ?s)
					 ("maildir:/IHEP/Refile"                                       "Refile"                 ?r)
					 ("maildir:/IHEP/Trash"                                        "Trash"                  ?t)
					 ("maildir:/IHEP/Drafts"                                       "Drafts"                 ?d)
					 ("maildir:/IHEP/INBOX AND mime:image/*"                       "Messages with images"   ?p)))
                     ))

           ,(make-mu4e-context
             :name "COREMAIL"
             :enter-func (lambda ()
                           (mu4e-message "Switch to the COREMAIL context")
                           (mu4e-update-index))
             :match-func (lambda (msg)
                           (when msg
                             (string-match-p "qiulin15@mails.ucas.ac.cn" (mu4e-message-field msg :maildir))))

             :vars '((user-mail-address             . "qiulin15@mails.ucas.ac.cn")
                     (mu4e-sent-folder              . "/COREMAIL/Sent")
                     (mu4e-drafts-folder            . "/COREMAIL/Drafts")
                     (mu4e-trash-folder             . "/COREMAIL/Trash")
                     (mu4e-refile-folder            . "/COREMAIL/Refile")
                     (smtpmail-default-smtp-server  . "mail.cstnet.cn")
                     (smtpmail-smtp-server          . "mail.cstnet.cn")
                     (smtpmail-smtp-service         . 25)
                     (mu4e-get-mail-command         . "offlineimap")
                     (mu4e-maildir-shortcuts . (("/COREMAIL/INBOX"   . ?i)
						("/COREMAIL/Sent"    . ?s)
						("/COREMAIL/Refile"  . ?r)
						("/COREMAIL/Trash"   . ?t)
						("/COREMAIL/Drafts"  . ?d)))
                     (mu4e-bookmarks . ( ("maildir:/COREMAIL/INBOX AND flag:unread AND NOT flag:trashed"   "Unread messages"        ?u)
					 ("maildir:/COREMAIL/INBOX AND date:today..now"                    "Today's messages"       ?t)
					 ("maildir:/COREMAIL/INBOX AND date:7d..now"                       "Last 7 days"            ?w)
					 ("maildir:/COREMAIL/INBOX AND date:1d..now"                       "Last 1 days"            ?o)
					 ("maildir:/COREMAIL/INBOX"                                        "Inbox"                  ?i)
					 ("maildir:/COREMAIL/Sent"                                         "Sent"                   ?s)
					 ("maildir:/COREMAIL/Refile"                                       "Refile"                 ?r)
					 ("maildir:/COREMAIL/Trash"                                        "Trash"                  ?t)
					 ("maildir:/COREMAIL/Drafts"                                       "Drafts"                 ?d)
					 ("maildir:/COREMAIL/INBOX AND mime:image/*"                       "Messages with images"   ?p)))
                     ))))

  ;; start with the first (default) context;
  ;; default is to ask-if-none (ask when there's no context yet, and none match)
  (setq mu4e-context-policy 'pick-first)


  ;; auto enable the org-mu4e-compose-org-mode when enter the mu4e-compose-mode
  (add-hook 'mu4e-compose-mode-hook
            (defun do-compose-stuff ()
              (org-mu4e-compose-org-mode)))

  (defun htmlize-and-send ()
    "When in an org-mu4e-compose-org-mode message, htmlize and send it."
    (interactive)
    (when (member 'org~mu4e-mime-switch-headers-or-body post-command-hook)
      (org-mime-htmlize)
      (message-send-and-exit)))

  (add-hook 'org-ctrl-c-ctrl-c-hook 'htmlize-and-send t)
  )
