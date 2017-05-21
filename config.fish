set fish_theme agnoster

alias vi vim

fish_vi_key_bindings
# vi modeではなんか[I]みたいなの出るからオーバーライド
function fish_mode_prompt 
end

## prompt
function fish_prompt 
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold red white
            case insert
                set_color --bold green white
            case replace-one
                set_color --bold green white
            case visual
                set_color --bold magenta white
            end
        echo (prompt_pwd) ">><(( *>  "
    end
end

#gitのbranch名出す
function git_branch
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
end

#右prompt
function fish_right_prompt
    echo (git_branch)
end
