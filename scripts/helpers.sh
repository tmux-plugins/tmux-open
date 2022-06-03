get_tmux_option() {
	local option="$1"
	local default_value="$2"
	local option_value
	option_value="$(tmux show-option -gqv "$option")"
	echo "${option_value:-$default_value}"
}

# Ensures a message is displayed for 5 seconds in tmux prompt.
# Does not override the 'display-time' tmux option.
display_message() {
	local message="$1"

	# display_duration defaults to 5 seconds, if not passed as an argument
	if [ "$#" -eq 2 ]; then
		local display_duration="$2"
	else
		local display_duration="5000"
	fi

	# saves user-set 'display-time' option
	local saved_display_time
	saved_display_time="$(get_tmux_option "display-time" "750")"

	# sets message display time to 5 seconds
	tmux set-option -gq display-time "$display_duration"

	# displays message
	tmux display-message "$message"

	# restores original 'display-time' value
	tmux set-option -gq display-time "$saved_display_time"
}

stored_engine_vars() {
	tmux show-options -g |
		grep -i "^@open-" |
		grep -Evi "^@open-(editor|opener)" |
		cut -d '-' -f2 |
		cut -d ' ' -f1 |
		xargs
}

get_engine() {
	local engine_var="$1"
	tmux show-options -g | grep -i "^@open-$engine_var" | cut -d ' ' -f2 | xargs
}

# The last grep is required to remove non-digits from version such as "3.0a".
tmux_version="$(tmux -V | cut -d ' ' -f 2 | grep -Eo '[0-9\.]+')"
tmux-is-at-least() {
	if [[ $tmux_version == "$1" ]]; then
		return 0
	fi

	IFS='.' read -r -a tver <<< "$tmux_version"
	IFS='.' read -r -a wver <<< "$1"

	# fill empty fields in tver with zeros
	for ((i=${#tver[@]}; i<${#wver[@]}; i++)); do
		tver[i]=0
	done

	# fill empty fields in wver with zeros
	for ((i=${#wver[@]}; i<${#tver[@]}; i++)); do
		wver[i]=0
	done

	for ((i=0; i<${#tver[@]}; i++)); do
		if ((10#${tver[i]} < 10#${wver[i]})); then
			return 1
		elif ((10#${tver[i]} > 10#${wver[i]})); then
			return 0
		fi
	done
	return 0
}
