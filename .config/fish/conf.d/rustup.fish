# Load Cargo/Rust environment for Fish
# We use 'test -r' to ensure the file exists and is readable, 
# and redirect stderr to /dev/null to remain silent during login.
if test -r "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish" 2>/dev/null
end
