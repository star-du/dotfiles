# Things to Do after this script:
# Run `:PlugInstall` in ~/.vimrc
# Install tmux ripgrep autojump
# e.g. brew install tmux ripgrep autojump

script_path="$(dirname "$0")"

# soft link config files
ln -sf "$script_path"/vim ~/.vim
ln -sf "$script_path"/vimrc ~/.vimrc
ln -sf "$script_path"/gitconfig ~/.gitconfig
ln -sf "$script_path"/tmux.conf ~/.tmux.conf

# Install oh-my-zsh
# Assume curl installed
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install p10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Put it here as installing oh-my-zsh will change zshrc
ln -sf "$script_path"/zshrc ~/.zshrc

# configure p10k
exec zsh