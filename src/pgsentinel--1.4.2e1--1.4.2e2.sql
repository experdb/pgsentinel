/* pgsentinel--1.4.2e1--1.4.2e2.sql */

-- complain if script is sourced in psql, rather than via ALTER EXTENSION
\echo Use "ALTER EXTENSION pgsentinel UPDATE TO '1.4.2e2'" to load this file. \quit

/*
 * e1 -> e2 carries no SQL change.
 *
 * e2 rebuilds the fork as a linear patch queue on upstream v1.4.2 instead of
 * the merge-tangled lineage e1 was cut from.  The compiled result is identical
 * -- pgsentinel.o is byte for byte the same once embedded __LINE__ values are
 * accounted for -- and pg_active_session_history() keeps the same 31-column
 * signature, so there is nothing to migrate.
 *
 * The script exists so installs already carrying e1 have a path to e2 rather
 * than being stranded on a version that is no longer the default.
 */
