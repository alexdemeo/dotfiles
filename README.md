# Alex's dotfiles

Assumption is that dotfiles is stores at "~/dotfiles"

1. Install homebrew

    ```zsh
    /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    ```

2. Install ansible

    ```zsh
    brew install ansible
    ```

3. Run ansible

    ```zsh
    cd "$HOME/dotfiles/ansible"
    ansible-playbook main.yaml
    ```
