/*
* SPDX-License-Identifier: GPL-3.0-or-later
* SPDX-FileCopyrightText: 2025 Alain <alainmh23@gmail.com>
*/

public class EmojiIndicator.Widgets.PopoverWidget : Gtk.Grid {
    public Gtk.SearchEntry search_entry;
    private Gtk.FlowBox flowbox;
    private Gtk.Popover? popover;
    private Gtk.Clipboard clipboard;

    construct {
        search_entry = new Gtk.SearchEntry () {
            hexpand = true,
            margin_top = 3,
            margin_start = 6,
            margin_end = 6
        };

        flowbox = new Gtk.FlowBox () {
            row_spacing = 6,
            column_spacing = 6,
            homogeneous = true,
            selection_mode = SINGLE,
            min_children_per_line = 7,
            margin_start = 6,
            margin_end = 6,
            margin_bottom = 6,
            hexpand = true,
            vexpand = true
        };
        flowbox.child_activated.connect (child_activated);
        flowbox.set_filter_func (filter_func);

        var flowbox_scrolled = new Gtk.ScrolledWindow (null, null) {
            hscrollbar_policy = NEVER,
            max_content_height = 250,
            width_request = 275,
            propagate_natural_height = true,
            child = flowbox,
            hexpand = true,
            vexpand = true
        };

        var content_box = new Gtk.Box (VERTICAL, 6);
        content_box.add (search_entry);
        content_box.add (flowbox_scrolled);

        realize.connect (() => {
            popover = (Gtk.Popover) get_ancestor (typeof (Gtk.Popover));
        });

        attach (content_box, 0, 0);

        clipboard = Gtk.Clipboard.get_default (Gdk.Display.get_default ());

        try {
            var parser = new Json.Parser ();
            parser.load_from_file (DATADIR + "/list.json");

            var root = parser.get_root ().get_object ();

            unowned Json.Array emojis = parser.get_root ().get_object ().get_array_member ("emojis");
			foreach (unowned Json.Node _node in emojis.get_elements ()) {
                flowbox.add (new Widgets.EmojiChild (new Objects.Emoji.from_json (_node)));
            }
        }  catch (Error e) {
            
		}

        search_entry.search_changed.connect (() => {
            flowbox.invalidate_filter ();
        });
    }

    private void child_activated (Gtk.FlowBoxChild child) {
        var emoji = ((Widgets.EmojiChild) child).emoji;

        clipboard.set_text (emoji.emoji, -1);
        popover.popdown ();
    }

    private bool filter_func (Gtk.FlowBoxChild child) {
        var emoji = ((Widgets.EmojiChild) child).emoji;
        return search_entry.text.down () in emoji.name.down ();
    }
}