# IPConfig-R3

As the name suggests, IPConfig-R3 is a simple bundle of chrome extension and some bat scripts that performs the flush, release and renew on the DNS and IP configurations of the system with just a click of a button on the chrome's extension bar.

## Installation

- Clone the repository to your local machine.
  
  `git clone https://github.com/anshgoyalevil/IPConfig-R3`
- Make sure you have the chrome browser installed on your system.
- Open the chrome browser and type `chrome://extensions/` in the address bar.
- Enable the developer mode by clicking on the toggle switch on the top right corner.
- Click on the `Load unpacked` button and select the folder where you have cloned the repository.
- The extension will be added to the chrome browser.
- Copy the extension ID from the extension card. We will need this ID while running the bat script.
- Run the `setup.bat` file in administrator mode by right-clicking on the file and selecting `Run as administrator`.
- Paste the extension ID when prompted and press enter.
- The setup is complete.

## Usage

- Click on the extension icon on the chrome's extension bar.
- Wait for the extension to perform the flush, release and renew operations. It would redirect you automatically to the `JioNet` login page after 10 seconds.

## How it works?

- It uses the `chrome.runtime.sendNativeMessage` method to send a message to native driver which runs the bat scripts.
- The setup script creates a registry key in the `HKEY_LOCAL_MACHINE\SOFTWARE\Google\Chrome\NativeMessagingHosts` directory with the extension ID as the value and the path to the native driver manifest that is dynamically generated as the data.
- The runnable bat script is automatically stored in the `%USERPROFILE%\Documents\run_bat` directory.
- The native driver runs that bat script to perform the flush, release and renew operations.