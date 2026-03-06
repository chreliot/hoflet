# `hoflet` LaTeX class

Write letters on your Hofstra University letterhead in LaTeX. Rendered example here.

## Design goals

* Though a few minutes of set-up work is required on first use, after that it should be as simple and fast as possible to produce a well-formatted letter on department letterhead in LaTeX.
* An opinionated design for a standard letter is hard-coded (but user-editable), and then letter-elements (like a signature graphic) may be *removed* with class options, rather than the other way around. 


## Features

  * Drop your letterhead graphics and signature files in once, and they'll be used in your letters forevermore.
  * Your `.tex` file for each letter will be clean, with just a few address-macros in the preamble, and just the letter content in the body.
  * Using LuaLaTeX, your letter should be tagged for assistive-reading devices.
  * As it's based on the `article` class, this class is much less restrictive about what can be included than is the LaTeX standard `letter` class. You *might* want to write a letter with an image or a table, after all!
  * Everything here should be easy to modify and customize to your usage—the class file, the template, et al. 
  
## One-time set-up
 
  1. Put `hoflet.cls` in your LaTeX path, for example `~/Library/texmf/tex/latex/`. (Of course it could also be in the same directory as the `.tex` file itself.)
  2. The class is set up to expect a sibling directory/folder called `images`. (You could, however change where `images` lives by adjusting the `\graphicspath` on about line 31 of the `.cls`.) As is, the class expects this sort of arrangement inside your letters folder: 
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
  3. The `images` folder you create should contain three files:  (1) `department-header.png`, (2) `department-footer.png`, and (3) `signature.png`. You can easily grab your letterhead's header and footer images from the Word document version of the letterhead for your unit. Save those image files as `.png` files with these names, in the `images` folder. Similarly, save a photo (or whatever) of your signature as `signature.png` in the same place. ~~Typesetting should complete just fine if a signature file isn't available.~~ It won't complete without the letterhead header and footer files, and, for the moment, a signature file. Todo: insert blank space if `signature.png` is missing.

## Notes on usage

  * The only thing that *needs* to be in the preamble of your letter file is content for each of the macros. Example content is in the sample file. The macros are:
    * `\recipient{}` → e.g., `\recipient{Charles Darwin}`, recipient's name
    * `\salutation{}` → e.g., `\salutation{Mr. Darwin}`, inserted after “Dear …” 
    * `\mailingaddress{}` → e.g., `\mailingaddress{Luxted Rd\\ Downe, Kent\\ BR6 7JT}`
    * `\myfullname{}` → e.g., `\myfullname{Christopher H. Eliot}`
    * `\myposition{}` → e.g., `\myposition{Associate Professor}`
  * The class doesn't lock in a font. You could add one in the preamble with `fontspec` or hard code one in the class file. (Otherwise, it runs fine with the default Computer Modern.)
  * The class doesn't lock in a font size. So you can declare a font size as a class option. I've been using `\documentclass[12pt]{hoflet}`.
  * Typeset with LuaLaTeX. If you have the included `.latexmk` configuration file, you can typeset with just, e.g., `latexmk Braun-tenure.tex`. Otherwise, I would use `latexmk --lualatex -pv -bibtex- Braun-tenure.tex`. Or whatever works for you.
 
 ## Class options
 
 <dl>
   <dt><tt>report</tt></dt>
   <dd>This deletes the recipient's name and address and the salutation (“Dear …”), but it retains the date. This is useful for generating peer-observation reports and other items on letterhead that aren't addressed to anyone.</dd>
   <dl>
    <dt><tt>noclosing</tt></dt>
    <dd>This completely deletes everything after the body.</dd>
   <dt><tt>nosignature</tt></dt>
   <dd>This replaces the signature image with blank space, but retains the sign-off (“Respectfully submitted,”) and sender's name. This might be useful for unsigned, draft versions of letters, or for leaving a space to sign manually. It has the same effect as the file `signature.png` being missing, but it leaves the space for a signature even if that file is present.</dd>
   <dt><tt>noletterhead</tt></dt>
    <dd>This replaces the letterhead images with the same-size whitespace. This is useful if you begin a letter using the class but then need to print it on acutal letterhead.</dd>
 </dl>
 
Class options go in the usual place. For example: 
```
\documentclass[noclosing]{hoflet}
```
 
 ## An optional shell-script for quick letter-template folders
 
A fast way to begin a letter is to navigate to your letters folder and run the little, included bash script that sets up a letter. The `writeltr.sh` script generates a subfolder with a template letter inside. You would presumably run it in your letters folder that contains an `images` folder, as above. As is, the script will also initialize git version control. You may want to modify the script for your purposes.
 
When I begin a letter, I navigate to my Letters folder and just type `bash writeltr.sh`. The script interactively asks for a last name (like “Darwin”) and a letter-purpose (like “tenure”), which it uses for file-naming. It then creates a blank template letter inside an appropriately titled folder.
 
The script also creates a `materials` folder and a `.taskpaper` file. (That's an open, plain-text task-list format used by various apps including the MacOS Taskpaper app.) I put résumés and other reference materials for the subject of the letter in the `materials` folder, and I list to-dos like “include a comment about Senate” in the `.taskpaper` list. Comment out those lines if you prefer.
 
Finally, the script initializes git version control and pulls down a `.gitignore` file from GitHub. Note, if you use it, that the script currently uses the GitHub CLI script `gh` to pull down a LaTeX `.gitignore` file from GitHub. It assumes that's installed; you would need to install `gh` or comment that line out of the script.
 
 ## Questions or suggestions?
 
 Please feel welcome to contact me (Christopher.H.Eliot at our university) with questions or suggestions. Please feel welcome to fork this and/or customize it. Happy letter-writing.