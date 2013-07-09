chef-mushroomobserver Cookbook
=========================

Chef cookbook for creating Mushroom Observer (http://mushroomobserver.org) systems

Requirements
------------
No requirements so far, but I hope to have some someday.

e.g.
#### packages - Do packages mean other cookbooks or something else?  For now I'll list the cookbooks
- `build-essential` - need to be able to build stuff.
- `mysql` - good old MySQL (really should try Postgres one of these days)
- `database` - gotta have a database (got this from the EOL recipe, not sure what it does yet)

Attributes
----------
No attributes yet, but I hope to have some someday.

e.g.
#### chef-mushroomobserver::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['rails_environment']</tt></td>
    <td>'test', 'development' or 'production'</td>
    <td>Indicates which database should be created.</td>
    <td><tt>development</tt></td>
  </tr>
  <tr>
    <td><tt>['mo_db_pass']</tt></td>
    <td>string</td>
    <td>Password for the 'mo' database user.</td>
    <td><tt>secure_password</tt></td>
  </tr>
  <tr>
    <td><tt>['repo_path']</tt></td>
    <td>string</td>
    <td>Path for the local mushroom repository.</td>
    <td></td>
  </tr>
</table>

Usage
-----

#### chef-mushroomobserver::default == chef-mushroomobserver::standalone

default is what most users will do most of the time which is create a standalone development machine

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-mushroomobserver]"
  ]
}
```

#### chef-mushroomobserver::standalone

standalone recipe loads the test database

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-mushroomobserver::standalone]"
  ]
}
```

#### chef-mushroomobserver::production

production recipe gets and loads the production database and does all the other stuff needed for the production machine

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-mushroomobserver::production]"
  ]
}
```

#### chef-mushroomobserver::dump_production

dump_production recipe dumps the current production database and copies it to files/prod.sql.
Requires ssh access to the production machine.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-mushroomobserver::dump_production]"
  ]
}
```

#### chef-mushroomobserver::create_init

create_init recipe creates an updated version of init.sql which contains no private information and can be used to
bootstrap the development environment.  Requires the existence of the prod.sql which requires ssh access to the
production machine.

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-mushroomobserver::dump_production]"
  ]
}
```

#### chef-mushroomobserver::db

db recipe installs and does basic configuration of the database.
This recipe is not expected to be run by itself.

#### chef-mushroomobserver::app

app recipe installs Ruby, gems and the MO source code.
This recipe is not expected to be run by itself.

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Nathan Wilson
License: MIT (like all things Mushroom Observer)
