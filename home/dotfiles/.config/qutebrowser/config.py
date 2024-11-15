# Autogenerated config.py
#
# NOTE: config.py is intended for advanced users who are comfortable
# with manually migrating the config file on qutebrowser upgrades. If
# you prefer, you can also configure qutebrowser using the
# :set/:bind/:config-* commands without having to write a config.py
# file.
#
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html
# import custom

# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(True)

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set("content.cookies.accept", "all", "chrome-devtools://*")

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`. If this setting is used with URL patterns, the pattern gets
# applied to the origin/first party URL of the page making the request,
# not the request URL. With QtWebEngine 5.15.0+, paths will be stripped
# from URLs, so URL patterns using paths will not match. With
# QtWebEngine 5.15.2+, subdomains are additionally stripped as well, so
# you will typically need to set this setting for `example.com` when the
# cookie is set on `somesubdomain.example.com` for it to work properly.
# To debug issues with this setting, start qutebrowser with `--debug
# --logfilter network --debug-flag log-cookies` which will show all
# cookies being set.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set("content.cookies.accept", "all", "devtools://*")

# Value to send in the `Accept-Language` header. Note that the value
# read from JavaScript is always the global value.
# Type: String
config.set("content.headers.accept_language", "", "https://matchmaker.krunker.io/*")

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}",
    "https://web.whatsapp.com/",
)

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value. With QtWebEngine
# between 5.12 and 5.14 (inclusive), changing the value exposed to
# JavaScript requires a restart.
# Type: FormatString
config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0",
    "https://accounts.google.com/*",
)

# Load images automatically in web pages.
# Type: Bool
config.set("content.images", True, "chrome-devtools://*")

# Load images automatically in web pages.
# Type: Bool
config.set("content.images", True, "devtools://*")

# Allow JavaScript to read from or write to the clipboard. With
# QtWebEngine, writing the clipboard as response to a user interaction
# is always allowed.
# Type: String
# Valid values:
#   - none: Disable access to clipboard.
#   - access: Allow reading from and writing to the clipboard.
#   - access-paste: Allow accessing the clipboard and pasting clipboard content.
c.content.javascript.clipboard = "access"

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "chrome-devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "devtools://*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "chrome://*/*")

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "qute://*/*")

# Allow locally loaded documents to access remote URLs.
# Type: Bool
config.set(
    "content.local_content_can_access_remote_urls",
    True,
    "file:///home/alejg/.local/share/qutebrowser/userscripts/*",
)

# Allow locally loaded documents to access other local URLs.
# Type: Bool
config.set(
    "content.local_content_can_access_file_urls",
    False,
    "file:///home/alejg/.local/share/qutebrowser/userscripts/*",
)

# Make characters in hint strings uppercase.
# Type: Bool
c.hints.uppercase = True
c.zoom.default = "110%"

# Position of the tab bar.
# Type: Position
# Valid values:
#   - top
#   - bottom
#   - left
#   - right
c.tabs.position = "top"

# When to show the tab bar.
# Type: String
# Valid values:
#   - always: Always show the tab bar.
#   - never: Always hide the tab bar.
#   - multiple: Hide the tab bar if only one tab is open.
#   - switching: Show the tab bar when switching tabs.
c.tabs.show = "multiple"

# Value to use for `prefers-color-scheme:` for websites. The "light"
# value is only available with QtWebEngine 5.15.2+. On older versions,
# it is the same as "auto". The "auto" value is broken on QtWebEngine
# 5.15.2 due to a Qt bug. There, it will fall back to "light"
# unconditionally.
# Type: String
# Valid values:
#   - auto: Use the system-wide color scheme setting.
#   - light: Force a light theme.
#   - dark: Force a dark theme.
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = False

config.bind(";m", "hint links spawn mpv {hint-url}")
config.bind(";:", "hint images right-click")
config.bind(
    "sy", "hint links spawn yt-dlp -o '~/Downloads/%(title)s.%(ext)s' {hint-url}"
)
config.bind("<Ctrl-Shift-PgDown>", "tab-move +")
config.bind("<Ctrl-Shift-PgUp>", "tab-move -")
config.bind("<Ctrl-l>", "cmd-set-text :open {url:pretty}")
# config.bind("<Ctrl-t>", "cmd-set-text -s :open -t")
config.bind(",m", "spawn mpv {url:pretty}")
config.bind(",yy", "spawn yt-dlp -P ~/Downloads/videos {url:pretty}")
config.bind(",yp", "spawn yt-dlp -P ~/Desktop/alejg/vid {url:pretty}")
config.bind(
    ",ym",
    "spawn yt-dlp --extract-audio --audio-quality 0 --audio-format mp3 -P ~/Desktop/mp3 {url:pretty}",
)


config.bind(
    "ca",
    "set -t content.javascript.clipboard access ;; cmd-later 60s set -p content.javascript.clipboard none",
)
# config.unbind("d")
config.unbind("<Ctrl-q>")
config.unbind("r")
config.bind("<Ctrl-r>", "reload")
config.bind("d", "tab-clone")
config.bind("<Ctrl-v>", "insert-text {clipboard}")
config.bind("<Ctrl-tab>", "tab-next", mode="normal")
config.bind("<Ctrl-tab>", "tab-next", mode="insert")
config.bind("<Ctrl-Shift-tab>", "tab-prev", mode="normal")
config.bind("<Ctrl-Shift-tab>", "tab-prev", mode="insert")
config.bind("<Ctrl-PgUp>", "tab-prev", mode="insert")
config.bind("<Ctrl-PgDown>", "tab-next", mode="insert")
config.bind("<Ctrl-w>", "tab-close", mode="insert")
config.bind("<Ctrl-t>", "open -t", mode="insert")

# sessions
config.bind(",ss", "cmd-set-text -s :session-save -o ")
config.bind(",sl", "cmd-set-text -s :session-load ")
config.bind(",sd", "cmd-set-text -s :session-delete ")
# https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query={}
c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?hl=en&q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "y": "https://www.youtube.com/results?search_query={}",
    "np": "https://search.nixos.org/packages?channel=unstable&from=0&size=100&sort=relevance&type=packages&query={}",
    "no": "https://search.nixos.org/options?channel=unstable&size=500&sort=relevance&type=packages&query={}",
    "ali": "https://aliexpress.com/w/{}.html?spm=a2g0o.productlist.search.0",
    "ebay": "https://www.ebay.com/sch/i.html?_nkw={}",
    "nix": "https://github.com/search?q={}+language%3ANix+&type=code",
    # "gt": "https://translate.google.com/?sl=en&tl=es&text={}&op=translate",
    "gt": "https://translate.google.com/?sl=auto&tl=es&text={}&op=translate",
    "solotodo": "https://www.solotodo.cl/search?search={}",
}


for i in range(1, 10):
    config.bind(f"<Ctrl-{i}>", f"tab-focus {i}")


# filechooser = ["foot", "-e", "sh", "-c", 'cd && yazi --chooser-file="$1"', "_", "{}"]
# c.fileselect.handler = "external"
# c.fileselect.single_file.command = filechooser
# c.fileselect.multiple_files.command = filechooser
# c.fileselect.folder.command = filechooser
# c.fileselect.single_file.command = ["lf", "-print-selection"]
# c.fileselect.multiple_files.command = ["lf", "-print-selection"]
# c.fileselect.folder.command = ["lf", "-print-selection"]
