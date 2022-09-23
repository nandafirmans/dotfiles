### Install Polybar

`sudo apt install polybar`
`sudo dnf install polybar`


### Install Material Icon Font 

`sudo cp -r ./material-icons /usr/share/fonts/opentype/material-icons`
`fc-cache`
`fc-list | grep Material`

if there are any issue loading icons on polybar then run this command
`sudo rm /etc/fonts/conf.d/70-no-bitmaps.conf`
then run `fc-cache`
please refer to this link for more information [https://github.com/polybar/polybar/wiki/Fonts#debugging-font-issues](https://github.com/polybar/polybar/wiki/Fonts#debugging-font-issues)

