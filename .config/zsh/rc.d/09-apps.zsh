#!/bin/zsh

load_nvm() {
    export NVM_DIR="${NVM_DIR:=${HOME}/.nvm}"
    if ! type nvm >/dev/null && [ -f "${NVM_DIR}/bin/nvm" ]; then
        export PATH="${NVM_DIR}/bin:${PATH}"
    fi

    if type nvm >/dev/null; then
        export PATH="${NVM_DIR}/bin:${NVM_DIR}/shims:${PATH}"
        [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh" --no-use
    fi
}

lazyload nvm node npm yarm npx -- load_nvm

load_pyenv() {
    export PYENV_ROOT="${PYENV_ROOT:=${HOME}/.pyenv}"
    if ! type pyenv >/dev/null && [ -f "${PYENV_ROOT}/bin/pyenv" ]; then
        export PATH="${PYENV_ROOT}/bin:${PATH}"
    fi

    if type pyenv >/dev/null; then
        eval "$(pyenv init -)"
    fi
}

lazyload pyenv python python3 pip -- load_pyenv

load_jenv() {
    export JENV_ROOT="${JENV_ROOT:=${HOME}/.jenv}"
    if ! type jenv >/dev/null && [ -f "${JENV_ROOT}/bin/jenv" ]; then
        export PATH="${JENV_ROOT}/bin:${PATH}"
    fi

    if type jenv >/dev/null; then
        eval "$(jenv init -)"
    fi
}

lazyload jenv java -- load_jenv
