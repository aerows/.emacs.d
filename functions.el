(defun capitalize-backwards ()
"Upcase the last letter of the word at point."
(interactive)
(backward-word 1)
(forward-word 1)
(backward-char 1)
(capitalize-word 1))

(defun insert-character-aa ()
(interactive)
(insert "å"))

(general-define-key :states '(insert emacs) 
		    :prefix "a"
		    "a" 'insert-character-aa
)
