# Create network namespace
create_ns () {
    NAME=$1
    IP=$2
    NETNS=faucet-${NAME}
    sudo ip netns add ${NETNS}
    sudo ip link add dev veth-${NAME} type veth peer name veth0 netns $NETNS
    sudo ip link set dev veth-${NAME} up
    sudo ip netns exec ${NETNS} ip link set dev veth0 up
    sudo ip netns exec ${NETNS} ip addr add dev veth0 $IP
    sudo ip netns exec ${NETNS} ip link set dev lo up
}

# Run command inside network namespace
as_ns () {
    NAME=$1
    NETNS=faucet-${NAME}
    shift
    sudo ip netns exec $NETNS $@
}

# Clean up namespaces, bridges and processes created during faucet tutorial
cleanup_ns () {
    for NETNS in $(sudo ip netns list | grep "faucet-" | awk '{print $1}'); do
        [ -n "$NETNS" ] || continue
        NAME=${NETNS#faucet-}
        if [ -f "/run/dhclient-${NAME}.pid" ]; then
            # Stop dhclient
            sudo pkill -F "/run/dhclient-${NAME}.pid"
        fi
        if [ -f "/run/iperf3-${NAME}.pid" ]; then
            # Stop iperf3
            sudo pkill -F "/run/iperf3-${NAME}.pid"
        fi
        if [ -f "/run/bird-${NAME}.pid" ]; then
            # Stop bird
            sudo pkill -F "/run/bird-${NAME}.pid"
        fi
        # Remove netns and veth pair
        sudo ip link delete veth-${NAME}
        sudo ip netns delete $NETNS
    done
    for DNSMASQ in /run/dnsmasq-vlan*.pid; do
        [ -e "$DNSMASQ" ] || continue
        # Stop dnsmasq
        sudo pkill -F "${DNSMASQ}"
    done
    # Remove faucet dataplane connection
    sudo ip link delete veth-faucet 2>/dev/null || true
    # Remove openvswitch bridge
    sudo ovs-vsctl del-br br0
}

# Add tagged VLAN interface to network namespace
add_tagged_interface () {
     NAME=$1
     IP=$2
     VLAN=$3
     NETNS=faucet-${NAME}
     sudo ip netns exec ${NETNS} ip link add link veth0 name veth0.${VLAN} type vlan id $VLAN
     sudo ip netns exec ${NETNS} ip link set dev veth0.${VLAN} up
     sudo ip netns exec ${NETNS} ip addr flush dev veth0
     sudo ip netns exec ${NETNS} ip addr add dev veth0.${VLAN} $IP
}

# Compile and execute a C source on the fly
csource() {
	[[ $1 ]]    || { echo "Missing operand" >&2; return 1; }
	[[ -r $1 ]] || { printf "File %s does not exist or is not readable\n" "$1" >&2; return 1; }
	local output_path=${TMPDIR:-/tmp}/${1##*/};
	gcc "$1" -o "$output_path" && "$output_path";
	rm "$output_path";
	return 0;
}

# cd and ls
cl() {
	local dir="$1"
	local dir="${dir:=$HOME}"
	if [[ -d "$dir" ]]; then
		cd "$dir" >/dev/null; ls -hall --color=auto
	else
		echo "bash: cl: $dir: Directory not found"
	fi
}

# take a note
note () {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch "$HOME/.notes"
    fi

    if ! (($#)); then
        # no arguments, print file
        cat "$HOME/.notes"
    elif [[ "$1" == "-c" ]]; then
        # clear file
        printf "%s" > "$HOME/.notes"
    else
        # add all arguments to file
        printf "%s\n" "$*" >> "$HOME/.notes"
    fi
}

# take a todo
todo() {
    if [[ ! -f $HOME/.todo ]]; then
        touch "$HOME/.todo"
    fi

    if ! (($#)); then
        cat "$HOME/.todo"
    elif [[ "$1" == "-l" ]]; then
        nl -b a "$HOME/.todo"
    elif [[ "$1" == "-c" ]]; then
        > $HOME/.todo
    elif [[ "$1" == "-r" ]]; then
        nl -b a "$HOME/.todo"
        eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
        read -p "Type a number to remove: " number
        sed -i ${number}d $HOME/.todo "$HOME/.todo"
    else
        printf "%s\n" "$*" >> "$HOME/.todo"
    fi
}

# calculate
calc() {
    echo "scale=3;$@" | bc -l
}

# dump-flows ovs function
dump-flows () {
  ovs-ofctl -OOpenFlow13 --names --no-stat dump-flows "$@" | sed 's/cookie=0x5adc15c0, //'
}

# save-flows ovs function
save-flows () {
  ovs-ofctl -OOpenFlow13 --no-names --sort dump-flows "$@"
}

# diff-flows ovs function
diff-flows () {
  ovs-ofctl -OOpenFlow13 diff-flows "$@" | sed 's/cookie=0x5adc15c0 //'
}
