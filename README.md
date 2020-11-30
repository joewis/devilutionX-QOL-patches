# devilutionX-QOL-patches
Gentoo ebuild with QOL improvements for [devilutionX](https://github.com/diasurgical/devilutionX)

## Contents
### QOL patches by [@Manuel-K](https://github.com/Manuel-K)
- Item Highight (press ALT key)
- Monster HP bar
- Left mouse button auto-clicker
- Run in town

### Additional Patches
- Max 50k gold per inventory field
- Show all players on map
- Moved Wirt to where we find him in Diablo II
- Teleport in town (Because, why not?)

Installation
============

Installation via the Gentoo overlay
-----------------------------------
The easiest way to add this overlay to your Portage tree is through eselect repository.

```
# eselect repository add devilutionx-overlay git https://github.com/spidertoast/devilutionX-QOL-patches
# emerge --sync
```

Or copy the ebuild into your local repo.

Manual compilation from source
------------------------------
[Download Devilutionx 1.1.0](https://github.com/diasurgical/devilutionX/releases/tag/1.1.0)

Unpack the tarball with
```
# tar xfz 1.1.0.tar.g
```

This mini-mod is provided as a series of patches to avoid constant rebases to track devilutionX development.

They can be applied by running
```patch -p1 < ../path_to.patch```
in the devilutionX directory.

Most of the patches are stand-alone. `infernity_item_hightlight_v04.patch` and `infernity_monster_hp_bar_v02.patch` require `infernity_common_v02.patch`.

After applying the patches, follow the instructions on [devilutionX](https://github.com/diasurgical/devilutionX)
