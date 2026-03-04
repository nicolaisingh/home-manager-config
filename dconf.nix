{ lib }:
{
  "org/gnome/desktop/input-sources" = {
    xkb-options = [
      "ctrl:nocaps"
      "lv3:switch"
      "shift:both_capslock"
    ];
  };
  "org/gnome/desktop/interface" = {
    font-hinting = "full";
    # gtk-key-theme = "Emacs";
    gtk-theme = "Orchis-Light";
  };
  "org/gnome/desktop/peripherals/keyboard" = {
    repeat-interval = lib.hm.gvariant.mkUint32 30;
    delay = lib.hm.gvariant.mkUint32 250;
  };
  "org/gnome/desktop/wm/preferences" = {
    resize-with-right-button = true;
  };
  "org/gnome/desktop/search-providers" = {
    disable-external = false;
    disabled = [
      "org.gnome.Characters.desktop"
      # "org.gnome.Software.desktop"
      "org.gnome.Contacts.desktop"
      "org.gnome.Boxes.desktop"
      "org.mozilla.firefox.desktop"
      "io.github.quodlibet.QuodLibet.desktop"
      "org.gnome.Nautilus.desktop"
    ];
    sort-order = [
      "org.gnome.Settings.desktop"
      "org.gnome.Contacts.desktop"
      "org.gnome.Nautilus.desktop"
      "org.gnome.Software.desktop"
    ];
  };
  "org/gnome/shell/extensions/caffeine" = {
    enable-mpris = true;
    indicator-position-max = 2;
    show-indicator = "always";
    show-notifications = false;
    user-enabled = false;
  };
  "org/gnome/shell/extensions/clipboard-indicator" = {
    clear-history = [ ];
    disable-down-arrow = true;
    display-mode = 0;
    history-size = 20;
    next-entry = [ ];
    paste-on-select = true;
    prev-entry = [ ];
    private-mode-binding = [ ];
    regex-search = true;
    toggle-menu = [ "<Shift><Super>v" ];
  };
  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    binding = "<Super>Return";
    command = "ptyxis";
    name = "Launch Terminal";
  };
  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
    binding = "<Shift><Super>Return";
    command = "emacsclient -c";
    name = "Launch Emacs Client";
  };
  "org/gnome/desktop/wm/keybindings" = {
    activate-window-menu = [ "<Super>w" ];
  };
}
