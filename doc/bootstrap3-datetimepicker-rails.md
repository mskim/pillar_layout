# bootstrap3-datetimepicker-rails

https://github.com/TrevorS/bootstrap3-datetimepicker-rails


$ gem install momentjs-rails
$ gem install bootstrap3-datetimepicker-rails

Add the following to your JavaScript manifest file (application.js):

//= require moment
//= require bootstrap-datetimepicker
If you want to include a localization, also add:

//= require moment/<locale>
Add the following to your style sheet file:

If you are using SCSS, modify your application.css.scss

// import bootstrap-sprockets before bootstrap if using bootstrap >= 3.2
@import 'bootstrap-sprockets';
@import 'bootstrap';
@import 'bootstrap-datetimepicker';
