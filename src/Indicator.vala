/*
* SPDX-License-Identifier: GPL-3.0-or-later
* SPDX-FileCopyrightText: 2025 Alain <alainmh23@gmail.com>
*/

public class EmojiIndicator.Indicator : Wingpanel.Indicator {
    private Gtk.Image display_widget;
    private Widgets.PopoverWidget popover_widget;

    public const string SHORTCUT = "<Super>e";
    public const string ID = "io.github.ellie_commons.wingpanel-indicator-emoji-picker";

    public Indicator () {
        Object (
            code_name : ID
        );
    }

    construct {
        GLib.Intl.bindtextdomain (GETTEXT_PACKAGE, LOCALEDIR);
        GLib.Intl.bind_textdomain_codeset (GETTEXT_PACKAGE, "UTF-8");

        // Set shortcut
        set_shortcut ();

        visible = true;
    }

    public override Gtk.Widget get_display_widget () {
        if (display_widget == null) {
            display_widget = new Gtk.Image () {
                icon_name = "face-smile-symbolic",
                pixel_size = 16
            }; 
        }

        return display_widget;
    }

    public override Gtk.Widget? get_widget () {
        if (popover_widget == null) {
            var provider = new Gtk.CssProvider ();
            provider.load_from_resource ("io/github/ellie_commons/wingpanel-indicator-emoji-picker/Indicator.css");
            
            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );

            popover_widget = new Widgets.PopoverWidget ();
        }

        return popover_widget;
    }

    public override void opened () {
        if (popover_widget == null) {
            return;
        }

        popover_widget.search_entry.grab_focus ();
    }

    public override void closed () {}
    
    private void set_shortcut () {
        Settings.CustomShortcutSettings.init ();
        bool has_shortcut = false;
        string shortcut_id = "io.elementary.wingpanel --toggle-indicator=%s".printf (ID);
                                      
        foreach (var shortcut in Settings.CustomShortcutSettings.list_custom_shortcuts ()) {
            if (shortcut.command == shortcut_id) {
                has_shortcut = true;
                return;
            }
        }

        if (!has_shortcut) {
            var shortcut = Settings.CustomShortcutSettings.create_shortcut ();
            if (shortcut != null) {
                Settings.CustomShortcutSettings.edit_shortcut (shortcut, SHORTCUT);
                Settings.CustomShortcutSettings.edit_command (shortcut, shortcut_id);
                send_power_notification ();
            }
        }
    }
    
    private void send_power_notification () {
        var notification = new Notify.Notification (
            _("Keyboard Shortcut Configured"),
            _("Use Super + E to open the Emoji Picker"),
            "face-smile"
        ) {
            id = int.parse (ID)
        };

        try {
            notification.show ();
        } catch (Error e) {

            critical ("Unable to show notification: %s", e.message);
        }
    }
}

public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
    debug ("Activating EmojiIndicator Indicator");

    if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
        return null;
    }

    var indicator = new EmojiIndicator.Indicator ();
    return indicator;
}