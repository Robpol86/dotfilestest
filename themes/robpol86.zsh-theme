PROMPT='[%D{%f}%(?.T.%F{red}T%f)%*] %F{yellow}%m%f:%F{cyan}%1~%f$(virtualenv_prompt_info)$(git_prompt_info) %(!.#.$) '
ZSH_THEME_GIT_PROMPT_PREFIX=" %B%F{green}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%f%b"
ZSH_THEME_VIRTUALENV_PREFIX=" %F{magenta}venv:("
ZSH_THEME_VIRTUALENV_SUFFIX=")%f"
