module main

import os
import flag

fn main() {
    mut bin_location := ''

    $if windows {
        // bin_location = 'TODO'
        println('Currently not supported on Windows.')
        exit(0)
    } $else $if linux {
        bin_location = '${os.home_dir()}/.cache/sd_bin'
        if !os.exists(bin_location) {
            os.mkdir(bin_location)!
            os.chmod(bin_location, 0o777)!
        }
    }

	mut fp := flag.new_flag_parser(os.args)
    fp.application('sd')
    fp.version('v0.0.1')
    // fp.limit_free_args(0, 0)! // comment this, if you expect arbitrary texts after the options
    fp.description('Recycler alternative for the rm coreutil')
    fp.skip_executable()
    is_forced := fp.bool('force', `f`, false, 'ignore nonexistent files and arguments, never prompt')
	is_prompt := fp.bool('prompt', `i`, false, 'prompt before every removal')
    is_verbose := fp.bool('verbose', `v`, false, 'explain what is being done')
    recursive := fp.bool('recursive', `r`, false, 'recurses directories')
    show_bin := fp.bool('bin', `b`, false, 'displays the recycling bin')

    nonargs := fp.finalize() or {
        eprintln(err)
        println(fp.usage())
        return
    }

	// println('forced? ${is_forced}, prompt? ${is_prompt} verbose? ${is_verbose} args: ${nonargs}')

    mut files := nonargs.clone()

    if show_bin {
        println('show bin')
        exit(0)
    }

    if nonargs.len == 0 {
        exit(0)
    }

    cwd := os.getwd()

    if !os.exists('${bin_location}${cwd}') {
            os.mkdir_all('${bin_location}${cwd}')!
    }

    for file in files {
        if is_verbose {
            println('Removing ${file}')
        }
        // os.rm('test/${file}')!
        // println('${bin_location}${cwd}')

        os.mv('${file}', '${bin_location}${cwd}') or {
            eprintln(err)
            exit(0)
        }
        // os.mv_by_cp('${file}', '${bin_location}${cwd}')!
    }
}