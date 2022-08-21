#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/helpers.sh"

default_open_key="o"
open_option="@open"

default_open_editor_key="C-o"
open_editor_option="@open-editor"
open_editor_override="@open-editor-command"

command_exists() {
	local command="$1"
	type "$command" >/dev/null 2>&1
}

is_osx() {
	local platform=$(uname)
	[ "$platform" == "Darwin" ]
}

is_cygwin() {
	[[ "$(uname)" =~ CYGWIN ]]
}

get_editor_from_the_env_var() {
	if [ -z $EDITOR ]; then
		# $EDITOR not set, fallback
		echo "vi"
	else
		echo "$EDITOR"
	fi
}

preserve_url_hash() {
	echo "sed s/##/####/g"
}

command_generator() {
	local command_string="$1"
	echo "$(preserve_url_hash) | xargs -I {} tmux run-shell -b 'cd #{pane_current_path}; $command_string \"{}\" > /dev/null'"
}

search_command_generator() {
	local command_string="$1"
	local engine="$2"

	echo "$(preserve_url_hash) | sed 's/\ /+/g' | xargs -I {} tmux run-shell -b 'cd #{pane_current_path}; $command_string $engine\"{}\" > /dev/null'"
}

generate_open_command() {
	if is_osx; then
		echo "$(command_generator "open")"
	elif is_cygwin; then
		echo "$(command_generator "cygstart")"
	elif command_exists "xdg-open"; then
		echo "$(command_generator "xdg-open")"
	else
		# error command for Linux machines when 'xdg-open' not installed
		"$CURRENT_DIR/scripts/tmux_open_error_message.sh" "xdg-open"
	fi
}

generate_open_search_command() {
	local engine="$1"
	if is_osx; then
		echo "$(search_command_generator "open" "$engine")"
	elif is_cygwin; then
		echo "$(command_generator "cygstart")"
	elif command_exists "xdg-open"; then
		echo "$(search_command_generator "xdg-open" "$engine")"
	else
		# error command for Linux machines when 'xdg-open' not installed
		"$CURRENT_DIR/scripts/tmux_open_error_message.sh" "xdg-open"
	fi
}

# 1. write a command to the terminal, example: 'vim -- some_file.txt'
# 2. invoke the command by pressing enter/C-m
generate_editor_command() {
	local environment_editor=$(get_editor_from_the_env_var)
	local editor=$(get_tmux_option "$open_editor_override" "$environment_editor")
	# vim freezes terminal unless there's the '--' argument. Other editors seem
	# to be fine with it (textmate [mate], light table [table]).
	echo "$(preserve_url_hash) | xargs -I {} tmux send-keys '$editor -- \"{}\"'; tmux send-keys 'C-m'"
}

set_copy_mode_open_bindings() {
	local open_command="$(generate_open_command)"
	local key_bindings=$(get_tmux_option "$open_option" "$default_open_key")
	local key
	for key in $key_bindings; do
		if tmux-is-at-least 2.4; then
			tmux bind-key -T copy-mode-vi "$key" send-keys -X copy-pipe-and-cancel "$open_command"
			tmux bind-key -T copy-mode    "$key" send-keys -X copy-pipe-and-cancel "$open_command"
		else
			tmux bind-key -t vi-copy    "$key" copy-pipe "$open_command"
			tmux bind-key -t emacs-copy "$key" copy-pipe "$open_command"
		fi
	done
}

set_copy_mode_open_editor_bindings() {
	local editor_command="$(generate_editor_command)"
	local key_bindings=$(get_tmux_option "$open_editor_option" "$default_open_editor_key")
	local key
	for key in $key_bindings; do
		if tmux-is-at-least 2.4; then
			tmux bind-key -T copy-mode-vi "$key" send-keys -X copy-pipe-and-cancel "$editor_command"
			tmux bind-key -T copy-mode    "$key" send-keys -X copy-pipe-and-cancel "$editor_command"
		else
			tmux bind-key -t vi-copy    "$key" copy-pipe "$editor_command"
			tmux bind-key -t emacs-copy "$key" copy-pipe "$editor_command"
		fi
	done
}

set_copy_mode_open_search_bindings() {
	local stored_engine_vars="$(stored_engine_vars)"
	local engine_var
	local engine
	local key

	for engine_var in $stored_engine_vars; do
		engine="$(get_engine "$engine_var")"

		if tmux-is-at-least 2.4; then
			tmux bind-key -T copy-mode-vi "$engine_var" send-keys -X copy-pipe-and-cancel "$(generate_open_search_command "$engine")"
			tmux bind-key -T copy-mode    "$engine_var" send-keys -X copy-pipe-and-cancel "$(generate_open_search_command "$engine")"
		else
			tmux bind-key -t vi-copy    "$engine_var" copy-pipe "$(generate_open_search_command "$engine")"
			tmux bind-key -t emacs-copy "$engine_var" copy-pipe "$(generate_open_search_command "$engine")"
		fi

	done
}

main() {
	set_copy_mode_open_bindings
	set_copy_mode_open_editor_bindings
	set_copy_mode_open_search_bindings
}

main
