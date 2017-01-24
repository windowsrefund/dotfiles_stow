# dotfiles

Inspired by http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html

## tmux

To bootstrap a new system, add these steps after using stow:

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then, inside a running session, type ```prefix + I``` to install all plugins
