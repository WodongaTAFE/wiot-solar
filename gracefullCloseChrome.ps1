# Get the main Chrome processes
$chromeProcesses = Get-Process -Name chrome -ErrorAction SilentlyContinue

if ($chromeProcesses) {
    # Define the SendMessage function from user32.dll
    Add-Type @"
        using System;
        using System.Runtime.InteropServices;
        public class User32 {
            [DllImport("user32.dll", SetLastError = true)]
            public static extern IntPtr SendMessage(IntPtr hWnd, UInt32 Msg, IntPtr wParam, IntPtr lParam);
        }
"@

    # Define the WM_CLOSE message constant
    $WM_CLOSE = 0x0010

    # Iterate through the Chrome processes
    foreach ($process in $chromeProcesses) {
        # Get the main window handle (HWND) of the Chrome process
        $hWnd = $process.MainWindowHandle

        # If the window handle is not zero, send the WM_CLOSE message
        if ($hWnd -ne [IntPtr]::Zero) {
            [void][User32]::SendMessage($hWnd, $WM_CLOSE, [IntPtr]::Zero, [IntPtr]::Zero)
        }
    }
}
