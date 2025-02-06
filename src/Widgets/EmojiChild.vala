/*
* SPDX-License-Identifier: GPL-3.0-or-later
* SPDX-FileCopyrightText: 2025 Alain <alainmh23@gmail.com>
*/

public class EmojiIndicator.Widgets.EmojiChild : Gtk.FlowBoxChild {
    public Objects.Emoji emoji { get; construct; }

    public EmojiChild (Objects.Emoji emoji) {
        Object (
            emoji: emoji
        );
    }

    construct {
        var emoji_label = new Gtk.Label (emoji.emoji);
        emoji_label.get_style_context ().add_class (Granite.STYLE_CLASS_H2_LABEL);

        child = emoji_label;
    }
}