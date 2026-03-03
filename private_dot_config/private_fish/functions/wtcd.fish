function wtcd --description "cd into an xudo worktree"
    if test (count $argv) -ne 1
        echo "Usage: wtcd <branch>"
        return 1
    end

    set -l wt_path (xudo wt path $argv[1])
    and cd $wt_path
end
