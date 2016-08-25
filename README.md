## Dependencies
  The test suite uses capybara with webkit for certain feature tests that require javascript to pass.
  This requires qt4 and Xcode developer tools.
  Qt version must be version 4 as versions 5+ cause font icons to dissapear and become unclickable for some unkown reason.
  Brew is not required to install Qt4, but makes the process a lot more simple.
  If you do not currently have brew installed, from the terminal run this command

```
 ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
then run
```
brew doctor
```
* Important! If you have capybara or capybara webkit gems installed, you must remove these by running commands gem uninstall capybara and gem uninstall capybara-webkit. After you complete the next steps, reinstall these gems. This will prevent any PATH errors.

Next, if you do not have Xcode version 5 or higher, install it from Apple Developer Downloads site. You may need to create an account to do this.

Once finished run the following terminal commands
```
If you have qt5 remove it using
brew remove qt5
then run
brew install qt4
brew linkapps qt4
brew link --force qt4
```
Following these steps should fix any problems running any tests using capybara webkit.

stats -
* average weekly spending, monthly spending.
* projected weekly spending based on current money spent this week
*
