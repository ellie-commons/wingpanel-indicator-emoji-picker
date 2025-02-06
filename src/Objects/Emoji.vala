/*
* SPDX-License-Identifier: GPL-3.0-or-later
* SPDX-FileCopyrightText: 2025 Alain <alainmh23@gmail.com>
*/

public class EmojiIndicator.Objects.Emoji : GLib.Object {
    public string emoji { get; set; default = ""; }
    public string name { get; set; default = ""; }
    public string category { get; set; default = ""; }
    public string subcategory { get; set; default = ""; }

    public Emoji () {}

    public Emoji.from_json (Json.Node node) {
        emoji = node.get_object ().get_string_member ("emoji");
        name = node.get_object ().get_string_member ("name");
        category = node.get_object ().get_string_member ("category");
        subcategory = node.get_object ().get_string_member ("subcategory");
    }
}