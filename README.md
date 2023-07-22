## VPN-Switch-Tool ##

VPN Switcher script is a versatile bash script that allows you to conveniently manage and switch between various VPN connections using NetworkManager on Linux systems. Whether you prefer UDP, TCP, or a random selection of VPNs, this script has got you covered. It provides an easy way to connect to your desired VPN, and it also displays useful connection information, including the connection speed and proxy settings.

## Prerequisites ##

Before using the VPN Switcher script, ensure that the following prerequisites are met:

- Linux operating system
- NetworkManager installed and running
- Bash shell

## Usage ##

To run the VPN Switcher script, open a terminal and navigate to the directory where the script is located. Then, execute the following command:

./vpn_switcher.sh <mode>


Replace `<mode>` with one of the following options:

- `udp`: Switch to a VPN connection using UDP protocol.
- `tcp`: Switch to a VPN connection using TCP protocol.
- `random`: Randomly select a VPN connection.

## Features

- **Multiple Connection Modes:** Choose between UDP, TCP, or random mode to suit your preferences.
- **Auto Connection Switching:** Automatically switch to the next available VPN in the list for the selected mode.
- **Proxy Information:** Show the proxy information associated with the active VPN.

## Example

./vpn_switcher.sh udp

Switched VPN. Connecting to VPN: YourVPN_UDP.
Proxy Info: none


## Configuration

The VPN Switcher script does not require any manual configuration. It automatically retrieves available VPN connections and their respective details using NetworkManager.

## Contributing

We welcome contributions to enhance the functionality and usability of the VPN Switcher script. Feel free to fork the repository, make improvements, and submit a pull request.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

---

Thank you for using the VPN Switcher script! If you encounter any issues or have suggestions for improvement, please don't hesitate to reach out and let us know. Happy browsing with your VPN connections! 🚀

