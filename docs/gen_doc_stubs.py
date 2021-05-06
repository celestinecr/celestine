# Generate virtual doc files for the mkdocs site.
# You can also run this script directly to actually write out those files, as a preview.

import os.path
import sys

import mkdocs_gen_files

root = mkdocs_gen_files.config["plugins"]["mkdocstrings"].get_handler("crystal").collector.root
celestine = root.lookup("Celestine")


def get_parts(typ):
    parts = typ.abs_id.split("::")
    assert parts[0] == "Celestine", parts
    return parts[1:]

nav = mkdocs_gen_files.Nav()

nav_items = {}

for typ in [celestine] + list(celestine.walk_types()):
    parts = typ.abs_id.split("::")
    if parts[-1] == 'Attrs':
        # Append to a pre-existing parent file
        filename = '/'.join(parts[:-1]) + '.md'
        with mkdocs_gen_files.open(filename, "a") as f:
            print(f"## ::: {typ.abs_id}\n\n", file=f)
        continue

    filename = '/'.join(parts) + '.md'
    with mkdocs_gen_files.open(filename, "w") as f:
        print(f"# ::: {typ.abs_id}\n\n", file=f)
    if typ.locations:
        mkdocs_gen_files.set_edit_path(filename, typ.locations[0].url)

    if len(parts) > 1:
        typ2 = celestine.lookup(parts[1])
        while (sup := typ2.superclass) and sup.abs_id.startswith("Celestine"):
            parts = sup.abs_id.split("::") + parts[1:]
            typ2 = sup.lookup()

    nav_items[tuple(["API"] + parts[1:])] = filename

for parts, filename in sorted(nav_items.items()):
    nav[parts] = filename


with mkdocs_gen_files.open("SUMMARY.md", "a") as nav_file:
    nav_file.writelines(nav.build_literate_nav())
