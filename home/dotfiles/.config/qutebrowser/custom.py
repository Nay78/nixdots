config.bind("z", "hint links spawn mpv {hint-url}")
config.bind(
    "Z", "hint links spawn youtube-dl -o '~/Downloads/%(title)s.%(ext)s' {hint-url}"
)
