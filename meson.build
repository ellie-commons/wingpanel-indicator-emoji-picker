project(
    'emoji-picker',
    'vala', 'c',
    version: '1.2.0',
    meson_version : '>= 0.58'
)

gnome = import('gnome')
i18n = import('i18n')
gettext_name = meson.project_name() + '-indicator'

prefix = get_option('prefix')
libdir = prefix / get_option('libdir')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(gettext_name), language:'c')
add_project_arguments('-DG_LOG_DOMAIN="io.github.ellie_commons.wingpanel-indicator-emoji-picker"', language:'c')

gresource = gnome.compile_resources(
    'as-resources',
    'data' / 'emoji-picker.gresource.xml',
    source_dir: 'data'
)

wingpanel_dep = dependency('wingpanel')
wingpanel_indicatorsdir = wingpanel_dep.get_variable('indicatorsdir', pkgconfig_define: ['libdir', libdir])

config_data = configuration_data()
config_data.set_quoted('LOCALEDIR', prefix / get_option('localedir'))
config_data.set_quoted('GETTEXT_PACKAGE', meson.project_name() + '-indicator')
config_data.set_quoted('DATADIR', prefix / get_option('datadir') / meson.project_name())
config_file = configure_file(
    input: 'src/Config.vala.in',
    output: '@BASENAME@',
    configuration: config_data
)

shared_module(
    meson.project_name(),
    'src/Indicator.vala',
    'src/Objects/Emoji.vala',
    'src/Settings/CustomShortcutSettings.vala',
    'src/Widgets/EmojiChild.vala',
    'src/Widgets/PopoverWidget.vala',
    config_file,
    gresource,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('granite', version: '>=6.0.0'),
        dependency('gtk+-3.0'),
        dependency('json-glib-1.0'),
        dependency('libnotify'),
        wingpanel_dep
    ],
    install: true,
    install_dir : wingpanel_indicatorsdir
)

subdir('data')
# subdir('po')

gnome.post_install(glib_compile_schemas: true)


