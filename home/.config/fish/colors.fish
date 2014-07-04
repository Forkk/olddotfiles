#!/bin/fish

set fish_color_file_vsn 2

function set_fish_colors
    set -U fish_color_autosuggestion    555\x1eyellow
    set -U fish_color_command           005fd7\x1epurple
    set -U fish_color_comment           red
    set -U fish_color_cwd               00af00
    set -U fish_color_cwd_root          red
    set -U fish_color_error             red\x1e\x2d\x2dbold
    set -U fish_color_escape            ff5f00
    set -U fish_color_history_current   ff5f00
    set -U fish_color_host              ff5f00
    set -U fish_color_match             ff5f00
    set -U fish_color_normal            normal
    set -U fish_color_operator          0000ff
    set -U fish_color_param             00afff
    set -U fish_color_quote             brown
    set -U fish_color_redirection       normal
    set -U fish_color_search_match      \x2d\x2dbackground\x3dpurple
    set -U fish_color_status            red
    set -U fish_color_user              00af00
    set -U fish_color_valid_path        \x2d\x2dunderline
    set -U fish_pager_color_completion  normal
    set -U fish_pager_color_description 555\x1eyellow
    set -U fish_pager_color_prefix      cyan
    set -U fish_pager_color_progress    cyan

    set -U -e fish_greeting
    set -U fish_key_bindings fish\x5fdefault\x5fkey\x5fbindings

    set -U fish_color_vsn $fish_color_file_vsn
    echo "Fish colors updated."
end


