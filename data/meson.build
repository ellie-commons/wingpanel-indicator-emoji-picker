i18n.merge_file(
    input: 'emoji-picker.metainfo.xml.in',
    output: 'io.github.ellie_commons.wingpanel-indicator-emoji-picker.metainfo.xml',
    po_dir: meson.project_source_root() / 'po' / 'extra',
    type: 'xml',
    install: true,
    install_dir: get_option('datadir') / 'metainfo',
)

install_data(
    'list.json',
    install_dir: get_option('datadir') / meson.project_name()
)

# install_data(
#     'keyboard.gschema.xml',
#     install_dir: get_option('datadir') / 'glib-2.0' / 'schemas',
#     rename: 'io.elementary.wingpanel.keyboard.gschema.xml'
# )