#!/usr/bin/env bash

terminate_vim_in_current_session() {
    tmux list-panes -sF "#{window_id} #{pane_id} #{pane_current_command}" | grep 'vim' | awk '/[0-9]+/{ print $1 " " $2 }' | while read windowId paneId; do
        tmux select-window -t $windowId
        tmux select-pane -t $paneId
        tmux send-keys :qall
        tmux send-keys Enter
    done
}

terminate_vim_in_sessions() {
    tmux list-sessions -F "#{session_id}" | while read sessionId; do
        tmux switch-client -n
        terminate_vim_in_current_session
    done
}

terminate_vim_in_current_session
