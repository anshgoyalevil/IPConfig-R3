chrome.action.onClicked.addListener(() => {
    chrome.runtime.sendNativeMessage('com.ansh.runbat', { message: "run_bat" }, (response) => {
        console.log("Response from runbat", response);
    });
});
