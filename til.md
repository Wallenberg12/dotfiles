# til

## javascript

Write code like it's synchrone

```javascript
let get = async (URL) => {
    const retval = await fetch(URL)
    if (retval.ok) {
        this.playlists = await retval.json()
    } else {
        console.error("doh! network error")
    }
}
get()
```

Or use promise chaining

```javascript
fetch(URL)
    .then(stream => stream.json())
    .then(data => this.playlists = data)
    .catch(error => console.error(error))
```
				
## bash

auto-reply `y` on installations or `fsck` repairs

    yes | pacman -S <something>

## ffmpeg

extract audio-only from video file with ID3 tags

    ffmpeg -i <input video>  -metadata title="Title" -metadata artist="Artist" -ab 256k file.mp3

## html

```html
<style type="text/css">
    table { page-break-inside:auto }
    tr    { page-break-inside:avoid; page-break-after:auto }
    thead { display:table-header-group }
    tfoot { display:table-footer-group }
</style>
```

## iptables

drop all but accept from one ip

    iptables -A INPUT -p tcp --dport 8000 -s 1.2.3.4 -j ACCEPT
    iptables -A INPUT -p tcp --dport 8000 -j DROP

drop all incomming ssh connections

    iptables -A INPUT -i eth0 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j DROP


## docker

Delete all containers
  * `docker rm $(docker ps -a -q)`
Delete all images
  * `docker rmi $(docker images -q)`

## git

Set git to use the credential memory cache

    git config --global credential.helper cache

Set the cache to timeout after 1 hour (setting is in seconds)

    git config --global credential.helper 'cache --timeout=3600'

Set default editor

    git config --global core.editor "vim"