const { map, unmap, mapkey, Normal } = api

mapkey('H', 'Go Back', () => { history.back() })
mapkey('L', 'Go Forward', () => { history.forward() })
mapkey('<Ctrl-d>', "Scroll down", () => { Normal.scroll("pageDown") })
mapkey('<Ctrl-u>', "Scroll up", () => { Normal.scroll("pageUp") })

// an example to remove mapkey `Ctrl-i`
map('J', 'R')
map('K', 'E')
map('F', 'gf')
map('<', '<<')
map('>', '>>')

unmap('R')
unmap('E')
unmap('d')
unmap('u')

settings.scrollStepSize = 100
settings.hintAlign = "left"
settings.defaultSearchEngine = "d"
// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`
