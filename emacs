;; -*- lexical-binding: t -*-
;; Enhanced Emacs configuration with file tree, IDEA theme and Java support

;; 1. 包管理初始化
(require 'package)
(setq package-archives '(("gnu"   . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; 2. 主题设置 (IDEA风格)
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)  ;; 类似IDEA的暗色主题
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 25
        doom-modeline-bar-width 4
        doom-modeline-lsp t
        doom-modeline-github t
        doom-modeline-mu4e t
        doom-modeline-irc t))

;; 3. 文件树导航 (类似IDEA的项目视图)
(use-package treemacs
  :ensure t
  :defer t
  :config
  (progn
    (setq treemacs-collapse-dirs 3
          treemacs-deferred-git-apply-delay 0.5
          treemacs-display-in-side-window t
          treemacs-eldoc-display t
          treemacs-file-event-delay 2000
          treemacs-file-follow-delay 0.2
          treemacs-follow-after-init t
          treemacs-git-command-pipe ""
          treemacs-goto-tag-strategy 'refetch-index
          treemacs-indentation 2
          treemacs-indentation-string " "
          treemacs-is-never-other-window nil
          treemacs-no-png-images nil
          treemacs-recenter-distance 0.1
          treemacs-recenter-after-file-follow nil
          treemacs-show-cursor nil
          treemacs-show-hidden-files t
          treemacs-silent-filewatch nil
          treemacs-silent-refresh nil
          treemacs-sorting 'alphabetic-desc
          treemacs-space-between-root-nodes t
          treemacs-tag-follow-cleanup t
          treemacs-tag-follow-delay 1.5
          treemacs-width 35)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (treemacs-git-mode 'extended)))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

;; 5. 通用设置
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)  ;; 显示相对行号

;; 6. 快捷键绑定
(global-set-key (kbd "C-x t") 'treemacs)  ;; 打开文件树
(global-set-key (kbd "M-j") 'lsp-java-generate-overrides)  ;; Java生成覆盖方法

;; 7. 自动补全
(use-package company
  :ensure t
  :config
  (global-company-mode)
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.1))

(use-package lsp-mode
  :ensure t
  :hook ((java-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; 启动时自动打开 Treemacs
(add-hook 'emacs-startup-hook 'treemacs)

;; 8. 启动时自动打开文件树
(add-hook 'emacs-startup-hook
          (lambda ()
            (treemacs)
            (split-window-horizontally)
            (other-window 1)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
