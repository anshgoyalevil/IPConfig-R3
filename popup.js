function startCountdown() {

    chrome.runtime.sendNativeMessage('com.ansh.runbat', { message: "run_bat" }, (response) => {
        console.log("Response from runbat", response);
    });

    let countdown = 10; // 10 seconds
    const countdownElement = document.getElementById('countdown');

    const interval = setInterval(() => {
        countdownElement.textContent = countdown;
        countdown--;

        // When countdown hits 0, redirect the user
        if (countdown < 0) {
            clearInterval(interval);

            // Use chrome.tabs.update() to redirect
            chrome.tabs.create({ url: "https://jionet2.jio.in:8443/" });
        }
    }, 1000);
}

window.onload = startCountdown;
