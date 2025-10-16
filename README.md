# `hoflet` LaTeX class

Write letters on your Hofstra University letterhead in LaTeX.

## Features

  * This uses your letterhead and signature files; drop them in once, as below, and they'll be used in your letters forevermore.
  * Your `.tex` file for each letter will be clean, with just a few address macros in the preamble, and just the letter content in the body.
  * Using LuaLaTeX, your letter should be tagged for reading in assistive devices.
  * Based on `article` class, this class is much less restrictive about what can be included than the LaTeX standard `letter` class. You *might* want to write a letter with an image or a table!
 * Everything here should be easy to modify and customize to your usage—the class file, the template, et al. 
  
## Set-up
 
  * Put `hoflet.cls` in your LaTeX path, for example `~/Library/texmf/tex/latex/`. (Of course it could also be in the same directory as the `.tex` file itself.)
  * The class is set up to expect a sibling directory/folder called `images`. (You could, however change where `images` lives by adjusting the `\graphicspath` on about line 31 of the `.cls`.) As is, the class expects this sort of arrangement inside the folder where your correspondence lives (mine is “Letters”): 
```
   ├── Braun-tenure
   │   └── Braun-tenure.tex
   ├── Darwin-promotion
   │   └── Darwin-promotion.tex
   └── images
	   ├── department-footer.png
	   ├── department-header.png
	   └── signature.png
```
  * The `images` folder you create should contain three files:  (1) `department-header.png`, (2) `department-footer.png`, and (3) `signature.png`. You can easily grab your letterhead's header and footer images from the Word document version of the letterhead for your unit. Save those image files as `.png` files with these names, in the `images` folder. Similarly, save a photo (or whatever) of your signature as `signature.png` in the same place. Typesetting should complete just fine if a signature file isn't available. It won't complete without the letterhead header and footer files. 

## Notes on usage

  * The only thing that *needs* to be in the preamble is content for each of the macros. Example content is in the sample file. The macros are:
    * `\recipient{}` → e.g., Charles Darwin
    * `\salutation{}` → e.g., Mr. Darwin 
    * `\mailingaddress{}` → e.g., Luxted Rd`\\` Downe, Kent`\\` BR6 7JT
    * `\myfullname{}` → e.g., Christopher H. Eliot
    * `\myposition{}` → e.g., Associate Professor
  * The class doesn't lock in a font. You could add one in the preamble with `fontspec` or hard code one in the class file. (Otherwise, it runs fine with the default Computer Modern.)
  * The class doesn't lock in a font size. So you can declare a font size as a class option. I've been using `\documentclass[12pt]{hoflet}`.
  * Typeset with LuaLaTeX. If you have the included `.latexmk` configuration file, you can typeset with just, e.g., `latexmk Braun-tenure.tex`. Otherwise, I would use `latexmk --lualatex -pv -bibtex- Braun-tenure.tex`. Or whatever works for you.
 
 ## An optional shell-script for quick letter-template folders
 
 Optionally, there's a little bash script included here called `writeltr.sh` that you can run in your letters folder to generate a folder with a template letter inside. As is, it will also initialize git version control. You'd probably want to customize it for your purposes.
 
 When I start a letter, I navigate to my Letters folder and just type `bash writeltr.sh`. The script interactively asks for a last name (like “Darwin”) and a letter-purpose (like “tenure”). In the version included here, it then creates a blank template letter inside an appropriately titled folder.
 
 The script also creates a `materials` folder and a `.taskpaper` file. (That's an open, plain-text task-list format used by various apps including the MacOS Taskpaper app.) Then the script initializes git version control and pulls down a `.gitignore` file from GitHub. Note, if you use it, that the script currently uses the GitHub CLI script `gh` to pull down a LaTeX `.gitignore` file from GitHub. It assumes that's installed; you would need to install `gh` or comment that line out of the script.
 
 ## Questions or suggestions?
 
 Please feel welcome to contact me (Christopher.H.Eliot at our university) with questions or suggestions. Please feel welcome to fork this and/or customize it to your heart's content. Happy letter-writing!