(cnfonts-mode)
(global-hungry-delete-mode 1)

(require 'mu4e)
(setq mu4e-contexts
      `( ,(make-mu4e-context
           :name "IHEP"
           :enter-func (lambda () (mu4e-message "Switch to the IHEP context"))
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :to "qiulin@ihep.ac.cn")))
           :vars '(  ( user-mail-address      . "qiulin@ihep.ac.cn"  )
                     (mu4e-sent-folder              . "/IHEP/Sent")
                     (mu4e-drafts-folder            . "/IHEP/Drafts")
                     (mu4e-trash-folder             . "/IHEP/Trash")
                     ( user-full-name     . "Lin Qiu" )
                     ( mu4e-compose-signature .
                       (concat
                        "Best wishes,\n"
                        "Lin Qiu"))))
         ,(make-mu4e-context
           :name "COREMAIL"
           :enter-func (lambda () (mu4e-message "Switch to the COREMAIL context"))
           :match-func (lambda (msg)
                         (when msg
                           (mu4e-message-contact-field-matches msg
                                                               :to "qiulin15@mails.ucas.ac.cn")))
           :vars '(  ( user-mail-address      . "qiulin15@mails.ucas.ac.cn" )
                     (mu4e-sent-folder              . "/COREMAIL/Sent")
                     (mu4e-drafts-folder            . "/COREMAIL/Drafts")
                     (mu4e-trash-folder             . "/COREMAIL/Trash")
                     ( user-full-name     . "Lin Qiu" )
                     ( mu4e-compose-signature .
                       (concat
                        "Best wishes,\n"
                        "Lin Qiu"))))))

(setq mu4e-attachment-dir "~/Downloads/")
(setq mu4e-maildir "~/.Maildir"
      mu4e-get-mail-command "offlineimap"
      mu4e-update-interval nil
      mu4e-compose-signature-auto-include nil
      mu4e-view-show-images t
      mu4e-view-show-addresses t)

;;; Mail directory shortcuts
(setq mu4e-maildir-shortcuts
      '(("/IHEP/INBOX" . ?g)
        ("/COREMAIL/INBOX" . ?c)))

;;; Bookmarks
(setq mu4e-bookmarks
      `(("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
        ("date:today..now" "Today's messages" ?t)
        ("date:7d..now" "Last 7 days" ?w)
        ("mime:image/*" "Messages with images" ?p)
        (,(mapconcat 'identity
                     (mapcar
                      (lambda (maildir)
                        (concat "maildir:" (car maildir)))
                      mu4e-maildir-shortcuts) " OR ")
         "All inboxes" ?i)))

(with-eval-after-load 'mu4e-alert
  (mu4e-alert-set-default-style 'notifier))   ; For macOS (through the

(setq send-mail-function 'smtpmail-send-it
    	message-send-mail-function 'smtpmail-send-it
      smtpmail-default-smtp-server "mail.ihep.ac.cn"
      smtpmail-smtp-server "mail.ihep.ac.cn"
      smtpmail-smtp-service 465
    	smtpmail-auth-credentials "~/.authinfo"
    	smtpmail-stream-type  'starttls)

(setq org-directory "~/Nutstore Files/Nutstore/org/")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-agenda-files '("~/Nutstore Files/Nutstore/org/"))
(setq org-journal-dir "~/Nutstore Files/Nutstore/org/journal/")
(setq org-journal-file-format "%Y-%m-%d")
(setq org-journal-date-prefix "#+TITLE: ")
(setq org-journal-date-format "%A, %B %d %Y")
(setq spaceline-org-clock-p t)

(setq bibtex-completion-bibliography '("~/Nutstore Files/Nutstore/Papers/references.bib")
      bibtex-completion-library-path "~/Nutstore Files/Nutstore/Papers/"
      bibtex-completion-notes-path "~/Nutstore Files/Nutstore/Papers/notes.org")

(setq lsp-julia-default-environment "~/.julia/environments/v1.11/")

(setq deft-directory "~/Nutstore Files/Nutstore/org/")
(setq deft-extensions '("org" "md" "txt"))
