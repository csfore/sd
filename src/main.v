module main

import os
import flag

fn main() {


	mut fp := flag.new_flag_parser(os.args)
    fp.application('sd')
    fp.version('v0.0.1')
    // fp.limit_free_args(0, 0)! // comment this, if you expect arbitrary texts after the options
    fp.description('Recycler alternative for the rm coreutil')
    fp.skip_executable()
    is_forced := fp.bool('force', `f`, false, 'ignore nonexistent files and arguments, never prompt')
	is_prompt := fp.bool('prompt', `i`, false, 'prompt before every removal')
    is_verbose := fp.bool('verbose', `v`, false, 'explain what is being done')

    nonargs := fp.finalize() or {
        eprintln(err)
        println(fp.usage())
        return
    }

	// println('forced? ${is_forced}, prompt? ${is_prompt} verbose? ${is_verbose} args: ${nonargs}')

    mut files := nonargs.clone()

    for file in files {
        if is_verbose {
            println('Removing ${file}')
        }
        println('delete here')
    }
}

// fn clean_args(mut args []string) []string {
//     for arg in args 
// }

// module main

// import os
// import cli

// fn main() {
//     mut app := cli.Command{
//         name: 'example-app'
//         description: 'example-app'
//         execute: fn (cmd cli.Command) ! {
//             println('no arguments provided.')
//             return
//         }
//         commands: [
//             cli.Command{
//                 name: '--sub'
//                 execute: fn (cmd cli.Command) ! {
//                     println('hello subcommand')
//                     return
//                 }
//             },
//         ]
//     }
//     app.setup()
//     app.parse(os.args)
// }