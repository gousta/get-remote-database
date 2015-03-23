# Introduction
Hi, I hope you find this script useful!

This script can:
1. Connect to a remote server
2. Connect to a PostgreSQL Server & export the preferred schema
3. Download the exported [schema].[DATE].sql to your computer
4. Delete the [schema] from your local PostgreSQL Server
5. Import the freshly downloaded [schema].[DATE].sql file to that schema

### How to use
The script should have execute permissions in order to be executable:
```
chmod u+x getjets.sh
```
Then simply run it by calling:
```
./getjets.sh
```

### Made with ❤ in Athens, Greece


1. First ordered list item
2. Another item
⋅⋅* Unordered sub-list. 
1. Actual numbers don't matter, just that it's a number
⋅⋅1. Ordered sub-list
4. And another item.

⋅⋅⋅You can have properly indented paragraphs within list items. Notice the blank line above, and the leading spaces (at least one, but we'll use three here to also align the raw Markdown).

⋅⋅⋅To have a line break without a paragraph, you will need to use two trailing spaces.⋅⋅
⋅⋅⋅Note that this line is separate, but within the same paragraph.⋅⋅
⋅⋅⋅(This is contrary to the typical GFM line break behaviour, where trailing spaces are not required.)

* Unordered list can use asterisks
- Or minuses
+ Or pluses
