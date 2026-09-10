# contrib/pgsentinel/src/meson.build

pgsentinel_sources = files(
  'get_parsedinfo.c',
  'pgsentinel.c',
)

if host_system == 'windows'
  pgsentinel_sources += rc_lib_gen.process(win32ver_rc, extra_args: [
    '--NAME', 'pgsentinel',
    '--FILEDESC', 'pgsentinel - active session history',])
endif

pgsentinel = shared_module('pgsentinel',
  pgsentinel_sources,
  kwargs: contrib_mod_args,
)
contrib_targets += pgsentinel

install_data(
  'pgsentinel.control',
  'pgsentinel--1.0.sql',
  'pgsentinel--1.0--1.3.1.sql',
  'pgsentinel--1.3.1--1.4.0.sql',
  'pgsentinel--1.4.0--1.4.1.sql',
  'pgsentinel--1.4.1--1.4.2e2.sql',
  'pgsentinel--1.4.2e1--1.4.2e2.sql',
  kwargs: contrib_data_args,
)

tests += {
  'name': 'pgsentinel',
  'sd': meson.current_source_dir(),
  'bd': meson.current_build_dir(),
  'regress': {
    'sql': [
      'pgsentinel-test',
    ],
    # pgsentinel.conf pins pgsentinel.db_name to 'contrib_regression', so the
    # background worker only collects samples from a database of that name.
    'regress_args': [
      '--temp-config', files('pgsentinel.conf'),
      '--dbname', 'contrib_regression',
    ],
    # Disabled because the test requires "shared_preload_libraries =
    # pg_stat_statements,pgsentinel", which typical runningcheck users do
    # not have (e.g. buildfarm clients).
    'runningcheck': false,
  },
}
