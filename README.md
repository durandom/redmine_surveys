# Redmine surveys

A Redmine plugin to create surveys.

## Installation and Setup

1. Follow the Redmine plugin installation steps at: http://www.redmine.org/wiki/redmine/Plugins 
2. Run the plugin migrations command: ```bundle exec rake redmine:plugins:migrate RAILS_ENV=production```
3. Restart your Redmine web servers
4. Login to Redmine as an Administrator
5. Configure the permissions for the plugin:  Create surveys,  View surveys,  View surveys results
6. Enable the survey plugin for a project

## Usage and features

A survey is basically just one question.

You can configure each survey:
* Allow edit (Users can edit their original answers)
* Allow comments (Also display a comment text field)
* Multiple choice
* Valid until (Dont allow answers after this date)

The results can be downloaded as a csv file.

## Security...

...does not exist. The above constraints (allow comment, etc.) are just implemented by showing or hiding the appropriate links. 
If you want tighter security you will also have to implement checks in the controller oder models.


## Internationalization

All strings can be translated.

Available languages:
	
* English
* Spanish

If you wann add your custom translation, add your lang file here: redmine_surveys/config/locales/


## License

This plugin is licensed under the GNU GPL v2.


## Authors

* Durandom: https://github.com/durandom
* Yaco: https://github.com/yaco

