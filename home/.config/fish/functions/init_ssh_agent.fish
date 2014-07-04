set agent_dir $HOME/.ssh/agent

# This function checks if an SSH agent is running and, if not, starts one.
function init_ssh_agent
	# Check if the agent is running.
	test -f $agent_dir/pid ^ /dev/null
	and kill -0 (cat $agent_dir/pid) ^ /dev/null

	# If the agent is running, use it.
	and use_ssh_agent
	# Otherwise, start a new agent.
	or start_ssh_agent $agent_dir
end

# This function starts a new SSH agent, dumps its info into a file and sets the
# appropriate environment variables.
function start_ssh_agent
	echo "Starting new SSH agent."

	# Start the agent and load the environment variables.
	eval (ssh-agent -c)

	# Make the agent folder if it doesn't exist.
	if not test -d $agent_dir
		mkdir -p $agent_dir
	end

	# Write the environment variables to files.
	echo $SSH_AGENT_PID > $agent_dir/pid
	echo $SSH_AUTH_SOCK > $agent_dir/sock
end

# This function loads the appropriate environment variables to use an existing
# SSH agent.
function use_ssh_agent
	set SSH_AGENT_PID (cat $agent_dir/pid)
	set SSH_AUTH_SOCK (cat $agent_dir/sock)
end

